import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/room_entity.dart';
import '../../../domain/use_case/fetch_rooms_usecase.dart';
import '../../../core/erros/network_exceptions.dart';
import '../../../domain/params/room_param.dart';
import 'room_list_states.dart';

class RoomListCubit extends Cubit<RoomListState> {
  final FetchRoomsUseCase _fetchRoomsUC;

  RoomListCubit(this._fetchRoomsUC) : super(RoomListInitial());

  List<RoomEntity> rooms = [];
  int currentPage = 1;
  int lastPage = 1;
  bool _isLoadingMore = false;

  // FIX Single ScrollController for all states
  //قبل كده، كل state كان عنده scrollController جديد، وده كان بيخلي القائمة تضيع مكانها عند إعادة تحميل البيانات
  final ScrollController scrollController = ScrollController();

  void setupScrollListener({required BuildContext context}) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          currentPage < lastPage) {
        loadMoreRooms(context: context);
      }
    });
  }

  Future<void> fetchRooms() async {
    if (state is RoomListLoading) return;

    emit(RoomListLoading());
    currentPage = 1;

    final result = await _fetchRoomsUC(RoomParams(page: currentPage));

    result.fold(
      (error) {
        if (error is NoInternetConnection) {
          emit(RoomListOffline());
        } else {
          emit(RoomListError(NetworkExceptions.getErrorMessage(error)));
        }
      },
      (response) {
        rooms = (response.data ?? []).toList();
        lastPage = response.paginates?.lastPage ?? currentPage;

        if (rooms.isEmpty) {
          emit(RoomListEmpty());
        } else {
          emit(RoomListLoaded(
            rooms: rooms,
            currentPage: currentPage,
            lastPage: lastPage,
            scrollController: scrollController,
          ));
        }
      },
    );
  }

  Future<void> loadMoreRooms({required BuildContext context}) async {
    final nextPage = currentPage + 1;
    if (_isLoadingMore || nextPage > lastPage) return;

    _isLoadingMore = true;
    final result = await _fetchRoomsUC(RoomParams(page: nextPage));

    try {
      result.fold(
        (error) {
          final message = NetworkExceptions.getErrorMessage(error);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
        (response) {
          final newRooms = response.data ?? [];
          rooms.addAll(newRooms);
          currentPage = nextPage;
          lastPage = response.paginates?.lastPage ?? lastPage;

          emit(RoomListLoaded(
            rooms: rooms,
            currentPage: currentPage,
            lastPage: lastPage,
            scrollController: scrollController,
          ));
        },
      );
    } finally {
      _isLoadingMore = false;
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
