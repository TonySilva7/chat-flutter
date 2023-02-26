import 'package:chat/app/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthFormData _formData = AuthFormData();

  void _handleSubmit() {
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(18),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _formData.isSignup
                  ? TextFormField(
                      key: const ValueKey('name'),
                      initialValue: _formData.name,
                      onChanged: (value) => _formData.name = value,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      keyboardType: TextInputType.text,
                    )
                  : const SizedBox.shrink(),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.name,
                onChanged: (value) => _formData.name = value,
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _formData.name,
                onChanged: (value) => _formData.name = value,
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSubmit,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => setState(() => _formData.toggleAuthMode()),
                child: Text(_formData.isLogin ? 'Criar uma nova conta?' : 'Já tenho uma conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
