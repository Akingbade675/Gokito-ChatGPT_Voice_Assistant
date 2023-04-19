import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatItem({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.white : const Color.fromARGB(255, 54, 177, 185),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: TextStyle(color: isMe ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}
