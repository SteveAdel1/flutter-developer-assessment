import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/fetch_rooms_usecase.dart';
import '../cubit/room_list/room_list_states.dart';
import '../cubit/room_list/room_list_cubit.dart';
import '../widgets/build_errors.dart';
import '../widgets/build_offline.dart';
import '../widgets/build_shimmers.dart';
import '../widgets/room_card.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({super.key});

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  late final RoomListCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = RoomListCubit(FetchRoomsUseCase());
    _cubit.fetchRooms();
    _cubit.setupScrollListener(context: context);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rooms')),
      body: BlocBuilder<RoomListCubit, RoomListState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is RoomListLoading || state is RoomListInitial) {
            return BuildShimmers();
          }

          if (state is RoomListError)
            return BuildErrors(
              message: state.message,
              cubit: _cubit,
            );
          if (state is RoomListOffline)
            return BuildOffline(
              cubit: _cubit,
            );
          if (state is RoomListEmpty) {
            return const Center(child: Text('No room available'));
          }
          if (state is RoomListLoaded) {
            return RefreshIndicator(
              onRefresh: _cubit.fetchRooms,
              child: ListView.builder(
                controller: state.scrollController,
                itemCount: state.rooms.length,
                itemBuilder: (context, index) {
                  return RoomCard(room: state.rooms[index]);
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
