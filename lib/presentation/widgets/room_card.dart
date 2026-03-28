import 'package:flutter/material.dart';
import '../../domain/entities/room_entity.dart';
import '../pages/room_screen_mini.dart';

class RoomCard extends StatelessWidget {
  final RoomEntity room;
  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomScreenMini(
              roomId: room.id,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage:
                room.coverUrl != null ? NetworkImage(room.coverUrl!) : null,
            child: room.coverUrl == null ? const Icon(Icons.room) : null,
          ),
          title:
              Text(room.roomName, maxLines: 2, overflow: TextOverflow.ellipsis),
          subtitle: Text('${room.visitorsCount} visitors'),
          trailing: room.isLive ? const Text('🔴 LIVE') : null,
        ),
      ),
    );
  }
}
