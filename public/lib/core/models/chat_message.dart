class ChatMessage {
  final String id;
  final String text;
  final DateTime createdAt;

  final String userid;
  final String username;
  final dynamic userImageURL;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userid,
    required this.username,
    required this.userImageURL,
  });
}
