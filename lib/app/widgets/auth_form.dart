import 'dart:io';

import 'package:chat/app/core/models/auth_form_data.dart';
import 'package:chat/app/utils/validator_form.dart';
import 'package:chat/app/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) handleSubmit;
  const AuthForm({super.key, required this.handleSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthFormData _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(msg)),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _submitForm() {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;
    if (_formData.image == null && _formData.isSignup) {
      _showError('Selecione uma imagem');
      return;
    }

    widget.handleSubmit(_formData);
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
              if (_formData.isSignup) UserImagePicker(onImagePick: _handleImagePick),
              _formData.isSignup
                  ? TextFormField(
                      key: const ValueKey('name'),
                      initialValue: _formData.name,
                      onChanged: (value) => _formData.name = value,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      keyboardType: TextInputType.text,
                      validator: (value) => ValidatorForm.validateName(value ?? ''),
                    )
                  : const SizedBox.shrink(),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.name,
                onChanged: (value) => _formData.email = value,
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => ValidatorForm.validateEmail(value ?? ''),
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _formData.name,
                onChanged: (value) => _formData.password = value,
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => ValidatorForm.validatePassword(value ?? ''),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
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
