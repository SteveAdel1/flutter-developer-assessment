import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/presentation/cubit/room/room_states.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit() : super(RoomInitial());

  String roomMode = 'normal';
  bool isCommentLocked = false;
  final List<String> messages = [];
  int seatCount = 8;

  void updateMode(String mode) {
    roomMode = mode;
    isCommentLocked = (mode == 'locked');

    emit(RoomLoaded(
      roomMode: roomMode,
      isCommentLocked: isCommentLocked,
      messages: List.unmodifiable(messages),
      seatCount: seatCount,
    ));
  }

  void addMessage(String msg) {
    messages.add(msg);
    emit(RoomLoaded(
      roomMode: roomMode,
      isCommentLocked: isCommentLocked,
      messages: List.unmodifiable(messages),
      seatCount: seatCount,
    ));
  }
}
