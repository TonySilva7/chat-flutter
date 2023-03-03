import 'dart:async';
import 'dart:io';

import 'package:chat/app/core/models/chat_user.dart';
import 'package:chat/app/core/models/chat_message.dart';
import 'package:chat/app/core/services/chat/chat_service_protocol.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServiceFirebase implements ChatServiceProtocol {
  @override
  Stream<List<ChatMessage>> messageStream() {
    return const Stream<List<ChatMessage>>.empty();
  }

  @override
  Future<ChatMessage?> save(String message, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    ChatMessage chatMessage = ChatMessage(
      id: '',
      text: message,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
    );

    final DocumentReference<ChatMessage> docRef = (await store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(chatMessage));

    final doc = await docRef.get();

    return doc.data()!;
  }

  ChatMessage _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    final Map<String, dynamic> data = doc.data()!;
    data.putIfAbsent('id', () => doc.id);

    return ChatMessage.fromMap(data);
  }

  Map<String, Object?> _toFirestore(ChatMessage chat, SetOptions? options) {
    return chat.toMapAPI();
  }
}
