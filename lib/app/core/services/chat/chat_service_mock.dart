import 'dart:async';

import 'package:chat/app/core/models/chat_user.dart';
import 'package:chat/app/core/models/chat_message.dart';
import 'package:chat/app/core/services/chat/chat_service_protocol.dart';

class ChatServiceMock implements ChatServiceProtocol {
  static final List<ChatMessage> _msgs = [];
  static MultiStreamController<List<ChatMessage>>? _controller;

  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messageStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String message, ChatUser user) async {
    DateTime dateTime = DateTime.now();
    final newMessage = ChatMessage(
      id: dateTime.millisecondsSinceEpoch.toRadixString(16),
      text: message,
      createdAt: dateTime,
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
    );

    // add a mensagem na lista
    _msgs.add(newMessage);
    // add a lista no stream
    _controller?.add(_msgs.reversed.toList());

    return newMessage;
  }
}
