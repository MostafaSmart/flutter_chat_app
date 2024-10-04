// import 'dart:io';

import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
// import 'package:http/http.dart' as http;

abstract class MassegRepository {
  Future<void> requestGetMassegsByConv(
      String accessToken, int conversationId);

  Future<List<MessageModel>> GetMassegsByChatIDFromLocal(int id);

  // Future<List<MessageModel>?> GetMassegCachConv(int id);
  // Future<void> saveAllNew(List<MessageModel> chatts);
  Future<MessageModel> sendNewMasseg(
      MessageModel chatts, int resever, String accessToken);
  Future<MessageModel> reSendMseg(
      MessageModel chatts, int resever, String accessToken);

  Future<void> saveNewMasseg(MessageModel newMasseg);
  // Future<void> clearAllMasseg();
}
