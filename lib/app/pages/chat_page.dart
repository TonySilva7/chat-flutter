import 'package:chat/app/core/services/auth/auth_service_factory.dart';
import 'package:chat/app/widgets/messages.dart';
import 'package:chat/app/widgets/new_message.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tony's Chat"),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 8),
                    const Text('Sair'),
                  ],
                ),
              ),
            ],
            onChanged: (Object? value) {
              if (value == 'logout') {
                AuthServiceFactory.create().logout();
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(
              child: Messages(),
            ),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
