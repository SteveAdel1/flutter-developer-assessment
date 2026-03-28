import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/presentation/cubit/room/room_states.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit() : super(RoomInitial());

  String roomMode = 'normal';
  bool isCommentLocked = false;
  List<String> messages = [];
  int seatCount = 8;

  void updateMode(String mode) {
    roomMode = mode;
    //  emit يعكس البيانات الحالية بدل ما يمسح القديم
    emit(RoomLoaded(
      roomMode: roomMode,
      isCommentLocked: isCommentLocked,
      messages: messages,
      seatCount: seatCount,
    ));
  }

  void addMessage(String msg) {
    messages.add(msg);
    //  كنا بنمسح الرسائل القديمة، دلوقتي بنضيف عليهم
    emit(RoomLoaded(
      roomMode: roomMode,
      isCommentLocked: isCommentLocked,
      messages: messages,
      seatCount: seatCount,
    ));
  }
}
