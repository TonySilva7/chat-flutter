import 'package:chat/app/core/models/chat_user.dart';
import 'package:chat/app/core/services/auth/auth_service_factory.dart';
import 'package:chat/app/core/services/auth/auth_service_protocol.dart';
import 'package:chat/app/pages/loading_pages.dart';
import 'package:flutter/material.dart';

import 'auth_page.dart';
import 'chat_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthServiceFactory.create().userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return snapshot.hasData ? const ChatPage() : const AuthPage();
          }
        },
      ),
    );
  }
}
