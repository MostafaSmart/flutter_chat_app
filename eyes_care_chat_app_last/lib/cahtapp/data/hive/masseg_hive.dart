import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:hive/hive.dart';

class MassegHive {
  

  Future<void> saveAllMessages(List<MessageModel> messages, int chat_id) async {
    final box = await openChatBox(chat_id);

    final messageData = messages
        .map<Map<String, dynamic>>((MessageModel message) => message.toJson())
        .toList();
    final Map<String, dynamic> messageMap = {
      for (var message in messageData) 'masseg_${message['id']}': message
    };

    // تخزين جميع الرسائل دفعة واحدة باستخدام putAll
    await box.putAll(messageMap);
  }

  Future<List<MessageModel>> getMessagesByConversationId2(int chat_id) async {
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

  Future<void> updataAddMessages(MessageModel messages) async {
    final box = await openChatBox(messages.conversationId);
    int id = messages.id;

    await box.put('masseg_$id', messages.toJson());
  }

  Future<void> clearMassegs(int chat_id) async {
    final box = await openChatBox(chat_id);

  await box.clear();
  }

  Future<Box> openChatBox(int conversationId) async {
    return await Hive.openBox('chat_$conversationId');
  }
}



  // Future<List<MessageModel>?> getMessagesByConversationId(int conversationId) async {
  //   List<MessageModel> messagesForConversation = [];

  //   final allKeys =
  //       _box.keys.where((key) => key.toString().startsWith('masseg_')).toList();

  //   for (var key in allKeys) {
  //     final messageData = _box.get(key);

  //     // تحقق إذا كانت البيانات ليست null
  //     if (messageData != null) {
  //       // تحويل البيانات إلى MessageModel
  //       final message =
  //           MessageModel.fromJson(Map<String, dynamic>.from(messageData));

  //       // إذا كانت الرسالة تتبع نفس conversationId، أضفها إلى القائمة
  //       if (message.conversationId == conversationId) {
  //         messagesForConversation.add(message);
  //       }
  //     }
  //   }

  //   return messagesForConversation; // إرجاع قائمة الرسائل التي تطابق conversationId
  // }
