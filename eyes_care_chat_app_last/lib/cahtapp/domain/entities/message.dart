

class MessageEntity {
  final int id;
  final int conversationId;
  final int senderId;
  final String content;
  final bool isRead;
  final bool isReceived;
  final DateTime timestamp;
  final String timeSince;
   String? file;
  

  MessageEntity(
      {
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.isRead,
    required this.isReceived,
    required this.timestamp,
    required this.timeSince,
    this.file,
  });
}
