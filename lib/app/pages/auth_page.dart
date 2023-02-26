import 'package:chat/app/core/models/auth_form_data.dart';
import 'package:chat/app/core/services/auth/auth_service_impl.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      setState(() => isLoading = true);
      if (formData.isLogin) {
        // Fazer login
        await AuthServiceImpl().login(formData.email, formData.password);
      } else {
        // Fazer cadastro
        await AuthServiceImpl().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } on Exception catch (e) {
      print(e);
      // Tratar o erro
    } finally {
      setState(() => isLoading = false);
    }
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
          if (isLoading)
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
