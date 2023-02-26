import 'package:chat/app/core/models/chat_user.dart';
import 'dart:io';

import 'package:chat/app/core/services/auth/auth_service.dart';

class AuthServiceImpl implements AuthService {
  @override
  // TODO: implement authStateChanges
  Stream<ChatUser?> get authStateChanges => throw UnimplementedError();

  @override
  // TODO: implement currentUser
  ChatUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> login(String email, String password) async {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> signup(String name, String email, String password, File image) async {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
