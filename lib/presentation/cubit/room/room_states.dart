
abstract class RoomState {}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final String roomMode;
  final bool isCommentLocked;
  final List<String> messages;
  final int seatCount;

  RoomLoaded({
    required this.roomMode,
    required this.isCommentLocked,
    required this.messages,
    required this.seatCount,
  });
}

class RoomError extends RoomState {
  final String message;
  RoomError(this.message);
}