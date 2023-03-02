import 'package:chat/app/core/models/chat_user.dart';
import 'package:chat/app/core/services/auth/auth_service_factory.dart';
import 'package:chat/app/pages/loading_pages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:chat/firebase_options.dart';
import 'auth_page.dart';
import 'chat_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          return StreamBuilder<ChatUser?>(
            stream: AuthServiceFactory.create().userChanges,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              } else {
                return snapshot.hasData ? const ChatPage() : const AuthPage();
              }
            },
          );
        }
      },
    );
  }
}
