import 'dart:async';

import 'package:chat/app/core/models/chat_user.dart';
import 'package:chat/app/core/models/chat_message.dart';
import 'package:chat/app/core/services/chat/chat_service_protocol.dart';

class ChatServiceMock implements ChatServiceProtocol {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Bom dia! Tem reunião hoje?',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Ana',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Bom dia, tem sim',
      createdAt: DateTime.now(),
      userId: '234',
      userName: 'Bia',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '1',
      text: 'Legal, estarei fora durante uma boa parte da manhã. Vai ser que horas?',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Ana',
      userImageURL: 'assets/images/avatar.png',
    ),
  ];
  MultiStreamController<List<ChatMessage>>? controller;

  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    controller = controller;
    controller.add(_msgs);
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
    controller?.add(_msgs);

    return newMessage;
  }
}
