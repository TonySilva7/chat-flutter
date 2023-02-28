import 'package:flutter/material.dart';

import '../core/services/auth/auth_service_factory.dart';
import '../core/services/chat/chat_service_factory.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  String _message = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthServiceFactory.create().currentUser;

    if (user != null) {
      await ChatServiceFactory.create().save(_message, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              onChanged: (value) => setState(() => _message = value),
              decoration: const InputDecoration(
                labelText: 'Nova mensagem',
              ),
            ),
          ),
          IconButton(
            onPressed: _message.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(
              Icons.send,
            ),
          ),
        ],
      ),
    );
  }
}
