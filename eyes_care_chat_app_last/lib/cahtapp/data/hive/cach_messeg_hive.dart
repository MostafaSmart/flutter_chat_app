import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:hive_flutter/adapters.dart';

class CachMessegeHive {
  // final _box = Hive.box('local_massege');

  Future<String> AddMessagesLocal(MessageModel messages) async {
    final box = await openChatBox(messages.conversationId);
    // int id = messages.id;

    String key = 'masseg_' + messages.timestamp.toIso8601String();

    await box.put('$key', messages.toJson());

    return key;
  }

  Future<List<MessageModel>> getAllMessagesLocal(int chat_id) async {
    final box = await openChatBox(chat_id);

    if (box.isEmpty) {
      return [];
    }

    final messageData = box.values;
    List<MessageModel> messages = messageData
        .map((messageJson) =>
            MessageModel.fromJson(Map<String, dynamic>.from(messageJson)))
        .toList();

    return messages;
  }

  Future<void> deleteMessegeLocalCache(
      MessageModel messages) async {
    String key = 'masseg_' + messages.timestamp.toIso8601String();
    final box = await openChatBox(messages.conversationId);

    if (box.containsKey(key)) {
      await box.delete(key);
    } else {
      print('not messeg local found');
    }
  }

  // Future<void> deleteLocalCachByIndex(int index) async {
  //   await _box.deleteAt(index);
  // }

  Future<Box> openChatBox(int conversationId) async {
    return await Hive.openBox('local_chat_$conversationId');
  }

  // Future<List<MessageModel>?> getAllMessagesLocal(int chat_id) async {
  //   // احصل على جميع المفاتيح التي تبدأ بـ "chat_"
  //   final allKeys =
  //       _box.keys.where((key) => key.toString().startsWith('conve_')).toList();

  //   // تحقق من أن هناك محادثات مخزنة
  //   if (allKeys.isEmpty) {
  //     return null; // لا توجد محادثات
  //   }

  //   try {
  //     final conversationData = allKeys.map((key) => _box.get(key)).toList();

  //     // حول البيانات المخزنة إلى كائنات ConversationModel
  //     List<MessageModel> conversations = conversationData
  //         .map<MessageModel>(
  //             (data) => MessageModel.fromJson(Map<String, dynamic>.from(data)))
  //         .toList();

  //     return conversations;
  //   } catch (e) {
  //     print('hive chat EXP');
  //   }

  //   return null;
  // }

//   Future<List<MessageModel>?> getMessagesByConversationId(int conversationId) async {
//     List<MessageModel>? messagesForConversation = [];

//     final allKeys =
//         _box.keys.where((key) => key.toString().startsWith('conve_')).toList();

//  if (allKeys.isEmpty) {
//       print('nullllllll');

//       return null; // لا توجد محادثات

//     }
//     try {
//     for (var key in allKeys) {
//       final messageData = _box.get(key);

//       // تحقق إذا كانت البيانات ليست null
//       if (messageData != null) {
//         // تحويل البيانات إلى MessageModel
//         final message =
//             MessageModel.fromJson(Map<String, dynamic>.from(messageData));

//         // إذا كانت الرسالة تتبع نفس conversationId، أضفها إلى القائمة
//         if (message.conversationId == conversationId) {
//           messagesForConversation.add(message);
//         }

//       print('nulllllll222222l yesre');

//       }

//         // return messagesForConversation;
//     }
//     }catch(e){

//     }

//     return messagesForConversation; // إرجاع قائمة الرسائل التي تطابق conversationId
//   }
}
