import 'package:equatable/equatable.dart';

class RoomEntity extends Equatable {
  final int id;
  final String roomName;
  final String? coverUrl;
  final int visitorsCount;
  final bool isLive;

  const RoomEntity({
    required this.id,
    required this.roomName,
    this.coverUrl,
    this.visitorsCount = 0,
    this.isLive = false,
  });

  @override
  List<Object?> get props => [id, roomName, coverUrl, visitorsCount, isLive];
}
