import 'package:flutter/material.dart';

import '../cubit/room_list/room_list_cubit.dart';

class BuildErrors extends StatelessWidget {
  const BuildErrors({super.key, required this.message, required this.cubit});
  final String message;
  final RoomListCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message.isEmpty ? 'Something went wrong' : message,
              style: const TextStyle(fontSize: 16, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: cubit.fetchRooms,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
