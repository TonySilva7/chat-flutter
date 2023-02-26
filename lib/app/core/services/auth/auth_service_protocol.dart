import 'dart:io';

import 'package:chat/app/core/models/chat_user.dart';

abstract class AuthServiceProtocol {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> signup(String name, String email, String password, File? image);
  Future<void> login(String email, String password);
  Future<void> logout();
}
