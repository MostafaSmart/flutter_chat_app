import 'package:eyes_care_chat_app_last/cahtapp/data/hive/chat_hive.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/conversation_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/remote/remote_conversation.dart';
import 'package:eyes_care_chat_app_last/cahtapp/domain/repositories/chat_repository.dart';
import 'package:eyes_care_chat_app_last/core/network_info.dart';

class ChatRepositoryImpl implements ChatRepository {
  final RemoteConversation remote_user = RemoteConversation();
   final chatBox = ChatHive();
  NetworkInfo networkInfo = NetworkInfoImpl();
  ChatRepositoryImpl();

  @override
  Future<void> requestGetAllConversation(
      String accessToken) async {
    List<ConversationModel>? chatts;

    // bool isConnected = await networkInfo.isConnected;

    try {
      if (await networkInfo.isConnected) {
      
        chatts = await remote_user.reqesutGetChat(accessToken);

        if(chatts!=null){
        
        await chatBox.saveAllChats(chatts);


        }


      
      }
    } catch (e) {
      print("rebostri: $e");
    }
    


  }




  @override
  Future<List<ConversationModel>> GetAllConversationFromLocal() async {
    List<ConversationModel> chatts = await chatBox.getAllChats();

    return chatts;
  }

  @override
  Future<void> saveAllChats(List<ConversationModel> chatts) async {
    await remote_user.saveAllNewChat(chatts);
  }

  @override
  Future<void> clearAllChats() async {
    await remote_user.clearAllChats();
  }

  @override
  Future<void> saveNewChat(ConversationModel chatts) async {
    await remote_user.saveNewChat(chatts);
  }
 @override
  Future<int> closeChat(ConversationModel chatts,String accessToken) async {
    return await remote_user.closeChatRequest(chatts,accessToken);
  }


}
