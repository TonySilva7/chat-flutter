import 'dart:async';

import 'package:chat/app/core/models/chat_user.dart';
import 'dart:io';

import 'package:chat/app/core/services/auth/auth_service_protocol.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceFirebase implements AuthServiceProtocol {
  static ChatUser? _currentUser;
  // static MultiStreamController<ChatUser?>? _controller;

  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    // pega a stream de dados do firebase e espelha para o _userStream
    final authChanges = FirebaseAuth.instance.authStateChanges();

    await for (final user in authChanges) {
      if (user == null) {
        _currentUser = null;
      } else {
        _currentUser = _toChatUser(user);
      }

      controller.add(_currentUser);
    }
  });

  static ChatUser _toChatUser(User user) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@').first,
      email: user.email!,
      imageURL: user.photoURL ?? 'assets/images/avatar.png',
    );
  }

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Future<void> login(String email, String password) async {}

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signup(String name, String mail, String pass, File? image) async {
    final auth = FirebaseAuth.instance;
    final UserCredential credential = await auth.createUserWithEmailAndPassword(email: mail, password: pass);

    if (credential.user != null) return;
    credential.user?.updateDisplayName(name);
    // credential.user?.updatePhotoURL(image?.path);
  }
}
