import 'dart:convert';
import 'package:eyes_care_chat_app_last/cahtapp/data/hive/chat_hive.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/conversation_model.dart';
import 'package:http/http.dart' as http;

class RemoteConversation {
  final chatBox = ChatHive();
  final http.Client client = http.Client();

  Future<List<ConversationModel>?> reqesutGetChat(String accessToken) async {
    final url = Uri.parse('http://192.168.43.59:8000/api/chat/conversations/');
    final response = await client.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final utf8DecodedBody = utf8.decode(response.bodyBytes);
      final chatDate = jsonDecode(utf8DecodedBody);

      final List<ConversationModel> posts = (chatDate as List)
          .map((cadata) => ConversationModel.fromJson(cadata))
          .toList();

      return posts;
    } else {
      return null;
    }
  }

  Future<int> closeChatRequest(
      ConversationModel conversations, String accessToken) async {
    final url = Uri.parse(
        'http://192.168.43.59:8000/api/chat/conversations/close/${conversations.id}/');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken', // إذا كان لديك نظام مصادقة
    };
    final response = await http.post(
      url,
      headers: headers,
      // body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final utf8DecodedBody = utf8.decode(response.bodyBytes);
      final massegsData = jsonDecode(utf8DecodedBody);
      print('sacsssssss_remote');

      return 1;
    } else {
      return 0;
    }
  }

  Future<void> saveAllNewChat(List<ConversationModel> conversations) async {
    await chatBox.saveAllChats(conversations);
  }

  Future<void> saveNewChat(ConversationModel conversations) async {
    await chatBox.updateAddChat(conversations);
  }

  Future<List<ConversationModel>?> getAllChats() async {
    final conversations = await chatBox.getAllChats();

    return conversations;
  }

  Future<void> clearAllChats() async {
    await chatBox.clearChats();
  }
}
