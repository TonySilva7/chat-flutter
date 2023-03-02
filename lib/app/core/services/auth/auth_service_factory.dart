import 'package:chat/app/core/services/auth/auth_service_firebase.dart';
import 'package:chat/app/core/services/auth/auth_service_protocol.dart';

class AuthServiceFactory {
  static AuthServiceProtocol create() {
    // return AuthServiceMock();
    return AuthServiceFirebase();
  }
}
