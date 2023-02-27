import 'package:chat/app/core/services/chat/chat_service_mock.dart';
import 'package:chat/app/core/services/chat/chat_service_protocol.dart';

class ChatServiceFactory {
  static ChatServiceProtocol create() {
    return ChatServiceMock();
  }
}
