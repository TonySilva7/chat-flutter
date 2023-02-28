import 'dart:io';

import 'package:chat/app/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble({super.key, required this.message, required this.belongsToCurrentUser});

  CircleAvatar _showUserImage(String imageURL, BuildContext context) {
    ImageProvider? provider;
    final uri = Uri.parse(imageURL);

    if (uri.scheme.contains('http') || uri.scheme.contains('https')) {
      provider = NetworkImage(imageURL);
    } else if (uri.scheme.contains('file')) {
      provider = FileImage(File(uri.toString()));
    } else {
      provider = const AssetImage('assets/images/avatar.png');
    }

    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.background,
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: belongsToCurrentUser ? Theme.of(context).colorScheme.secondary : Colors.grey[300],
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: belongsToCurrentUser ? const Radius.circular(12) : const Radius.circular(0),
                    bottomRight: belongsToCurrentUser ? const Radius.circular(0) : const Radius.circular(12)),
              ),
              // width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              // margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 35),
              margin: const EdgeInsets.only(top: 10, bottom: 5, left: 30, right: 30),
              constraints: BoxConstraints(
                minHeight: 20,
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Column(
                crossAxisAlignment: belongsToCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: belongsToCurrentUser ? Colors.white : Colors.black54,
                    ),
                  ),
                  Text(
                    message.text,
                    style: TextStyle(color: belongsToCurrentUser ? Colors.white : Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 5,
          right: belongsToCurrentUser ? 5 : null,
          child: _showUserImage(message.userImageURL, context),
        ),
      ],
    );
  }
}
