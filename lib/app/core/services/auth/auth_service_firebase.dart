import 'dart:async';

import 'package:chat/app/core/models/chat_user.dart';
import 'dart:io';

import 'package:chat/app/core/services/auth/auth_service_protocol.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthServiceFirebase implements AuthServiceProtocol {
  static ChatUser? _currentUser;
  // static MultiStreamController<ChatUser?>? _controller;

  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    // pega a stream de dados do firebase e espelha para o _userStream
    final authChanges = FirebaseAuth.instance.authStateChanges();

    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);

      controller.add(_currentUser);
    }
  });

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  static ChatUser _toChatUser(User user) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@').first,
      email: user.email!,
      imageURL: user.photoURL ?? 'assets/images/avatar.png',
    );
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);

    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signup(String name, String mail, String pass, File? image) async {
    final auth = FirebaseAuth.instance;
    final UserCredential credential = await auth.createUserWithEmailAndPassword(email: mail, password: pass);

    if (credential.user == null) return;

    // 1. Faz upload da foto do usuário
    final imageName = '${credential.user!.uid}.jpg';
    final imageURL = await _uploadUserImage(image, imageName);

    // 2. Atualiza os atributos do usuário (nome e foto)
    credential.user?.updatePhotoURL(imageURL);
    credential.user?.updateDisplayName(name);
  }
}
