
import 'package:eyes_care_chat_app_last/cahtapp/data/hive/cach_messeg_hive.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/hive/masseg_hive.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/remote/masseg_remote.dart';
import 'package:eyes_care_chat_app_last/cahtapp/domain/repositories/massegs_repository.dart';

import 'package:eyes_care_chat_app_last/core/network_info.dart';


class MassegRepositoryImpl implements MassegRepository {
  final MassegRemote massegRemote = MassegRemote();
  NetworkInfo networkInfo = NetworkInfoImpl();

  final masegBox = MassegHive();

  final cachMessegeHive = CachMessegeHive();

  @override
  Future<void> requestGetMassegsByConv(
      String accessToken, int conversationId) async {
    List<MessageModel> messages = [];
    try {
      if (await networkInfo.isConnected) {
        final apiMessages =
            await massegRemote.reqesutGetChat(accessToken, conversationId);

        final localMessages =
            await masegBox.getMessagesByConversationId2(conversationId);

        final localMessagesMap = {
          for (var message in localMessages) 'masseg_${message.id}': message,
        };

        for (var apiMessage in apiMessages) {
          apiMessage.isReceived = true;
          final localMessage = localMessagesMap['masseg_${apiMessage.id}'];

          // If message is not in local storage or if it's different (e.g., isRead updated), save it
          if (localMessage == null ||
              localMessage.isRead != apiMessage.isRead) {
            // await saveMessageToLocal(apiMessage);

            messages.add(apiMessage);
          }
        }

        await masegBox.saveAllMessages(messages, conversationId);
      }
    } catch (e) {
      print("rebostri: $e");
    }
  }

  @override
  Future<List<MessageModel>> GetMassegsByChatIDFromLocal(int chat_id) async {
    
    
    final messegs1 = await cachMessegeHive.getAllMessagesLocal(chat_id);

    final messegs2 = await masegBox.getMessagesByConversationId2(chat_id);

    List<MessageModel> masseg3 = [];
    
    masseg3.addAll(messegs1);
    masseg3.addAll(messegs2);

    return masseg3;
  }

  @override
  Future<MessageModel> reSendMseg(
      MessageModel chatts, int resever, String accessToken) async {
    MessageModel? newMasseg;
    if (await networkInfo.isConnected) {
      try {
        newMasseg =
            await massegRemote.sendNewMassegs(chatts, resever, accessToken);

        if (newMasseg != null) {
          await cachMessegeHive.deleteMessegeLocalCache(chatts);
          newMasseg.isReceived = true;
          newMasseg.timestamp = chatts.timestamp;
          await saveNewMasseg(newMasseg);
          print('sacsssssss_repost');

          return newMasseg;
        }
      } catch (e) {
        print('nulllllll_repost');
      }
    }

    return chatts;
  }

  @override
  Future<MessageModel> sendNewMasseg(
      MessageModel chatts, int resever, String accessToken) async {
    String key = await cachMessegeHive.AddMessagesLocal(chatts);

    MessageModel? newMasseg;

    if (await networkInfo.isConnected) {
      try {
        newMasseg =
            await massegRemote.sendNewMassegs(chatts, resever, accessToken);

        if (newMasseg != null) {
          print('1111_$key');

          await cachMessegeHive.deleteMessegeLocalCache(chatts);
          newMasseg.isReceived = true;
          await saveNewMasseg(newMasseg);
          print('sacsssssss_repost');

          return newMasseg;
        }
      } catch (e) {
        print('nulllllll_repost');
      }
    }

    return chatts;
  }



  @override
  Future<void> saveNewMasseg(MessageModel chatts) async {
    await masegBox.updataAddMessages(chatts);
  }

  // @override
  // Future<void> saveAllNew(List<MessageModel> chatts) async {
  //   for (var i = 0; i < chatts.length; i++) {
  //     chatts[i].isReceived = true;
  //   }

  //   await massegRemote.saveAllMassegs(chatts);
  // }
}
