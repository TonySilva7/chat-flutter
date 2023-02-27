import 'package:chat/app/core/models/chat_message.dart';
import 'package:chat/app/core/models/chat_user.dart';

abstract class ChatServiceProtocol {
  Stream<List<ChatMessage>> messageStream();
  Future<ChatMessage> save(String message, ChatUser user);
  // Stream<List<Message>> get messages;
}
