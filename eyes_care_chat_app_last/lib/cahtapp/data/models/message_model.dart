import 'package:eyes_care_chat_app_last/cahtapp/domain/entities/message.dart';

class MessageModel {
  final int id;
  final int conversationId;
  final int senderId;
  final String content;
  final bool isRead;
   bool isReceived;
   DateTime timestamp;
  final String timeSince;
    String? file;

  MessageModel({
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

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      conversationId: json['conversation'],
      senderId: json['sender'],
      content: json['content'],
      isRead: json['is_read'],
      isReceived: json['is_received'],
      timestamp: DateTime.parse(json['timestamp']),
      timeSince: json['time_since'],
      file: json['file'],
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation': conversationId,
      'content':content,
      'sender': senderId,
      'timestamp': timestamp.toIso8601String(),
      'is_read': isRead,
      'is_received':isReceived,
      'time_since':timeSince,
      'file': file,
    };
  }

    List<MessageModel> fromListJson(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => MessageModel.fromJson(json)).toList();
  }

    MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      conversationId: conversationId,
      content: content,
      senderId: senderId,
      timestamp: timestamp,
      isRead:isRead,
      isReceived: isReceived,
      timeSince:timeSince,
      file:file
    );
  }


  //   Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'conversationId': email,
  //     'senderId': firstName,
  //     'content': lastName,
  //     'isRead': userType,
  //     'access_token': accessToken,
  //     'refresh': refreshToken,
  //     'patient_id': patientId,
  //     'subscription_count': subscriptionCount,
  //     'subscription_status': subscriptionStatus,
  //   };
  // }
}
