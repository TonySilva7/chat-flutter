import 'dart:async';

import 'package:chat/app/core/models/chat_user.dart';
import 'dart:io';

import 'package:chat/app/core/services/auth/auth_service_protocol.dart';

class AuthServiceImpl implements AuthServiceProtocol {
  static final Map<String, ChatUser> _users = {};
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;

  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(null);
  });

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(String name, String email, String password, File? image) async {
    final seedId = DateTime.now();

    final user = ChatUser(
      id: seedId.millisecondsSinceEpoch.toRadixString(16),
      name: name,
      email: email,
      imageUrl: image?.path ?? '/assets/images/user.png',
    );

    _users.putIfAbsent(email, () => user);
    _updateUser(user);
  }
}
