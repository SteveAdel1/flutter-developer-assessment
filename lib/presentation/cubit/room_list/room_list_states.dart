import 'package:flutter/material.dart';
import '../../../domain/entities/room_entity.dart';


abstract class RoomListState {}


class RoomListInitial extends RoomListState {}

class RoomListLoading extends RoomListState {}

// Loaded state with room, pagination, and scroll controller
class RoomListLoaded extends RoomListState {
  final List<RoomEntity> rooms;
  final int currentPage;
  final int lastPage;
  final ScrollController scrollController;

  RoomListLoaded({
    required this.rooms,
    required this.currentPage,
    required this.lastPage,
    ScrollController? scrollController,
  }) : scrollController = scrollController ?? ScrollController();
}

class RoomListError extends RoomListState {
  final String message;
  RoomListError(this.message);
}

class RoomListEmpty extends RoomListState {}

class RoomListOffline extends RoomListState {}