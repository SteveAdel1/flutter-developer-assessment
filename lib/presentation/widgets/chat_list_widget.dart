import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  final List<String> messages;
  final ScrollController scrollController;

  const ChatList(
      {required this.messages, required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 300,
        child: ListView.separated(
          controller: scrollController,
          itemCount: messages.length,
          separatorBuilder: (_, __) => Divider(height: 1),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(messages[index], style: TextStyle(fontSize: 13)),
            );
          },
        ),
      ),
    );
    //  ScrollController يتحكم في القائمة بشكل صحيح ويمنع مشاكل الذاكرة
  }
}
