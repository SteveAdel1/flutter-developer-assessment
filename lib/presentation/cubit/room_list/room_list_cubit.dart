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

  // FIX  Typed room list properly (was dynamic)
  // مكنش ليهاtype
  List<RoomEntity> rooms = [];

  int currentPage = 1;
  int lastPage = 1;

  // FIX Single ScrollController for all states
  //قبل كده، كل state كان عنده scrollController جديد، وده كان بيخلي القائمة تضيع مكانها عند إعادة تحميل البيانات
  final ScrollController scrollController = ScrollController();

  void setupScrollListener({required BuildContext context}) {
    scrollController.addListener(() {
      // FIX Prevent loadMore if we reached lastPage
     //لو currentPage وصلت لآخر صفحة، أي محاولة لتحميل صفحة جديدة هتسبب request فاضية أو error
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent &&
          currentPage < lastPage) {
        loadMoreRooms(context: context);
      }
    });
  }

  Future<void> fetchRooms() async {
    emit(RoomListLoading());
    currentPage = 1;

    final result = await _fetchRoomsUC(RoomParams(page: currentPage));

    result.fold(
          (error) => emit(RoomListError(NetworkExceptions.getErrorMessage(error))),
          (response) {
        // FIX  Clear old room and cast properly
            //لما نعمل refresh للبيانات، كنا بنضيف الداتا الجديدة على القديمة بدون مسح القديم، وكنا ممكن نسيب النوع
            rooms = (response.data ?? [])
                .map((e) => e)
                .toList();

        // FIX Set lastPage safely
            // لو حاجة رجعت null فى الpagination info
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
    if (currentPage >= lastPage) return;

    currentPage++;
    final result = await _fetchRoomsUC(RoomParams(page: currentPage));

    result.fold(
          (error) {
        // لا تمسح الـ room، فقط اعرض رسالة
        final message = NetworkExceptions.getErrorMessage(error);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
          (response) {
        final newRooms = response.data ?? [];
        rooms.addAll(newRooms);
        lastPage = response.paginates?.lastPage ?? lastPage;

        emit(RoomListLoaded(
          rooms: rooms,
          currentPage: currentPage,
          lastPage: lastPage,
          scrollController: scrollController,
        ));
      },
    );
  }
}