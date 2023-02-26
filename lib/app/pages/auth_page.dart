import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Chat App'),
              SizedBox(height: 20),
              Text('Entre com sua conta'),
              SizedBox(height: 20),
              AuthForm(),
            ],
          ),
        ),
      ),
    );
  }
}
