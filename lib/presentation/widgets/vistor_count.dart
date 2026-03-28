import 'package:flutter/material.dart';

class VisitorCount extends StatelessWidget {
  final int count;
  const VisitorCount({super.key, required this.count});
  String formatVisitors(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.visibility, size: 12, color: Colors.grey),
        const SizedBox(width: 2),
        Text(
          formatVisitors(count),
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }
}
