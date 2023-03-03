class ChatMessage {
  final String id;
  final String text;
  final DateTime createdAt;

  final String userId;
  final String userName;
  final String userImageURL;

  ChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.userImageURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'createdAt': createdAt,
      'userId': userId,
      'userName': userName,
      'userImageURL': userImageURL,
    };
  }

  Map<String, dynamic> toMapAPI() {
    return {
      'text': text,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
      'userName': userName,
      'userImageURL': userImageURL,
    };
  }

  ChatMessage.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        text = map['text'],
        createdAt = DateTime.parse(map['createdAt']),
        userId = map['userId'],
        userName = map['userName'],
        userImageURL = map['userImageURL'];
}
