import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/other_userModel.dart';
import 'package:eyes_care_chat_app_last/cahtapp/domain/entities/conversation.dart';

class ConversationModel {
  final int id;
  final int user1;
  final int user2;
  final bool is_active;
  final DateTime createdAt;
   MessageModel lastMessage;
  final int? unread_messages_count;

  final OtherUserModel otherUser;

  ConversationModel(
      {required this.id,
      required this.user1,
      required this.user2,
      required this.is_active,
      required this.createdAt,
      required this.lastMessage,
      required this.unread_messages_count,
      required this.otherUser});

  // تحويل JSON إلى كائن Dart
  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      user1: json['user1'],
      user2: json['user2'],
      is_active: json['is_active'],
      unread_messages_count: json['unread_messages_count'],
      lastMessage: MessageModel.fromJson(json['last_message']),
      otherUser: OtherUserModel.fromJson(json['other_user'] ),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  factory ConversationModel.fromJson2(Map<String, dynamic> json) {
    
    
    return ConversationModel(
      id: json['id'],
      user1: json['user1'],
      user2: json['user2'],
      is_active: json['is_active'],
      unread_messages_count: json['unread_messages_count'],
    lastMessage: MessageModel.fromJson(Map<String, dynamic>.from(json['last_message'] as Map)),

      // lastMessage: MessageModel.fromJson(json['last_message']),
    otherUser: OtherUserModel.fromJson2(Map<String, dynamic>.from(json['other_user'] as Map)),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  List<ConversationModel> fromListJson(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => ConversationModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user1': user1,
      'user2': user2,
      'unread_messages_count':unread_messages_count,
      'created_at': createdAt.toIso8601String(),
      'last_message': lastMessage.toJson(),
      'is_active': is_active,
      'other_user': otherUser.toJson(),
    };
  }

  // تحويل الـ Model إلى Entity
  ConversationEntity toEntity() {
    return ConversationEntity(
      id: id,
      user1: user1,
      user2: user2,
      createdAt: createdAt,
      lastMessage: lastMessage,
      is_active: is_active,
      otherUser: otherUser,
    );
  }
}
