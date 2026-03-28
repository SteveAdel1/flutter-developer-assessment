import 'package:flutter/material.dart';

class SeatGrid extends StatelessWidget {
  final int seatCount;
  const SeatGrid({required this.seatCount, super.key});

  @override
  Widget build(BuildContext context) {
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
                Icon(Icons.person, color: Colors.grey),
                SizedBox(height: 4),
                Text('Seat ${index + 1}', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ),
        childCount: seatCount,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }
// شيلنا shrinkWrap و NeverScrollablePhysics لتحسين الأداء داخل CustomScrollView
}
