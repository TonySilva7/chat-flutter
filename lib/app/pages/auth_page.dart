import 'package:chat/app/models/auth_form_data.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  void _handleSubmit(AuthFormData formData) {
    print(formData.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Chat App'),
                  const SizedBox(height: 20),
                  const Text('Entre com sua conta'),
                  const SizedBox(height: 20),
                  AuthForm(handleSubmit: _handleSubmit),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
