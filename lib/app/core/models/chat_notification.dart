class ChatNotification {
  final String title;
  final String body;

  ChatNotification({
    required this.title,
    required this.body,
  });

  factory ChatNotification.fromMap(Map<String, dynamic> data) {
    if (data.isEmpty) {
      throw Exception('O mapa de dados não pode ser vazio');
    }

    final String title = data['title'];
    final String body = data['body'];

    return ChatNotification(
      title: title,
      body: body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
    };
  }
}
