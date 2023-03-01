import 'package:chat/app/core/models/chat_notification.dart';
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
}
