import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(18),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const Text('Criar uma nova conta?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
