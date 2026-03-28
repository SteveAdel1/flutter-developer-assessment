import 'dart:math';

import 'package:flutter/material.dart';

class SeatGrid extends StatelessWidget {
  final int seatCount;
  const SeatGrid({required this.seatCount, super.key});

  @override
  Widget build(BuildContext context) {
    final finalCount = max(0, seatCount);
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, color: Colors.grey),
                const SizedBox(height: 4),
                Text('Seat ${index + 1}', style: const TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ),
        childCount: finalCount,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }
}
