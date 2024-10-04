import 'package:eyes_care_chat_app_last/cahtapp/data/models/conversation_model.dart';
// import 'package:http/http.dart' as http;

abstract class ChatRepository {
  Future<void> requestGetAllConversation(String accessToken);

  Future<List<ConversationModel>?> GetAllConversationFromLocal();
  Future<void> saveAllChats(List<ConversationModel> chatts);
  Future<void> saveNewChat(ConversationModel chatts);

  Future<void> clearAllChats();
  Future<int> closeChat(ConversationModel chatts,String accessToken);
}
