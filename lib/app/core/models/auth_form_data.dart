import 'dart:io';

enum AuthMode { login, signup }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _authMode = AuthMode.login;

  bool get isLogin => _authMode == AuthMode.login;
  bool get isSignup => _authMode == AuthMode.signup;

  void toggleAuthMode() {
    _authMode = isLogin ? AuthMode.signup : AuthMode.login;
  }
}
