import 'package:chat/app/core/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier {
  final List<ChatNotification> _items = [];

  List<ChatNotification> get items => [..._items];

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  // push notification
  Future<void> init() async {
    await _configureTerminated();
    await _configureForeground();
    await _configureBackground();

    // await _checkToken();
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return true;
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  Future<void> _configureBackground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  Future<void> _configureTerminated() async {
    if (await _isAuthorized) {
      final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

      if (initialMessage != null) {
        _messageHandler(initialMessage);
      }
    }
  }

  void _messageHandler(RemoteMessage? message) {
    final RemoteNotification? notification = message?.notification;
    // final Map<String, dynamic> data = message.data;

    print('Mensagem: ${notification}');

    if (message == null || message.notification == null) return;

    add(ChatNotification(
      title: notification?.title ?? 'Não informado',
      body: notification?.body ?? 'Não informado',
    ));
  }

  // Future<void> _checkToken() async {
  //   final FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   final String? token = await messaging.getToken();

  //   print('Token: $token');
  // }
}
