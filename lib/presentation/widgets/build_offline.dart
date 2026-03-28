import 'package:flutter/material.dart';

import '../cubit/room_list/room_list_cubit.dart';

class BuildOffline extends StatelessWidget {
  const BuildOffline({super.key, required this.cubit});
  final RoomListCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.signal_wifi_off, size: 50, color: Colors.grey),
            const SizedBox(height: 12),
            const Text(
              'No internet connection',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
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
