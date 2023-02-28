import 'package:chat/app/core/models/chat_message.dart';
import 'package:chat/app/core/services/auth/auth_service_factory.dart';
import 'package:chat/app/core/services/chat/chat_service_factory.dart';
import 'package:chat/app/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUser = AuthServiceFactory.create().currentUser;
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatServiceFactory.create().messageStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Nenhuma mensagem'),
          );
        } else {
          final List<ChatMessage> messages = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) => MessageBubble(
              key: ValueKey(messages[index].id),
              message: messages[index],
              belongsToCurrentUser: currentUser?.id == messages[index].userId,
            ),
          );
        }
      },
    );
  }
}
