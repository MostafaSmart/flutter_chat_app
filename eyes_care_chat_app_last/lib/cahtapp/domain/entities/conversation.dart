import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/other_userModel.dart';

class ConversationEntity {
  final int id;
  final int user1;
  final int user2;
  final bool is_active;
  final DateTime createdAt;
  final MessageModel lastMessage;
  final OtherUserModel otherUser;

  ConversationEntity({
    required this.id,
    required this.user1,
    required this.user2,
    required this.is_active,
    required this.createdAt,
    required this.lastMessage,
    required this.otherUser,
  });
}
