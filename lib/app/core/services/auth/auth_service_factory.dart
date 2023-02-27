import 'package:chat/app/core/services/auth/auth_service_mock.dart';
import 'package:chat/app/core/services/auth/auth_service_protocol.dart';

class AuthServiceFactory {
  static AuthServiceProtocol create() {
    return AuthServiceMock();
  }
}
