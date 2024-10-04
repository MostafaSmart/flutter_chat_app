// data/repository/auth_repository_impl.dart

import 'package:eyes_care_chat_app_last/cahtapp/data/models/conversation_model.dart';
import 'package:hive/hive.dart';

class ChatHive {
  final _box = Hive.box('chats');
  Future<void> saveAllChats(List<ConversationModel> conversation) async {
    final conversationData = conversation
        .map<Map<String, dynamic>>(
            (ConversationModel message ) => message.toJson())
        .toList();

    for (var conv in conversationData) {
      var id = conv['id'];
      await _box.put('chat_$id', conv);
    }
  }

  Future<List<ConversationModel>> getAllChats() async {
    // احصل على جميع المفاتيح التي تبدأ بـ "chat_"
    final allKeys =
        _box.keys.where((key) => key.toString().startsWith('chat_')).toList();

    // تحقق من أن هناك محادثات مخزنة
    if (allKeys.isEmpty) {
      print('null hive conv');

      return []; 
    }

    try {
    final conversationData = allKeys.map((key) => _box.get(key)).toList();

    List<ConversationModel> conversations = conversationData
        .map<ConversationModel>((data) {
      // التأكد من أن البيانات هي Map<String, dynamic> 
      final dataMap = Map<String, dynamic>.from(data as Map); // تحويل البيانات إلى Map<String, dynamic>
      return ConversationModel.fromJson2(dataMap);
    }).toList();

    return conversations;
  }  catch (e) {
      print('hive chat EXP');
    }

    return [];
  }

  Future<void> clearChats() async {
    final allKeys =
        _box.keys.where((key) => key.toString().startsWith('chat_')).toList();

    // إذا كانت هناك محادثات مخزنة، قم بحذفها
    if (allKeys.isNotEmpty) {
      await _box.deleteAll(allKeys); // حذف جميع المفاتيح دفعة واحدة
    }
  }

  Future<ConversationModel?> getChatById(int id) async {
    final chatKey = 'chat_$id';

    final conversationData = _box.get(chatKey);

    if (conversationData != null) {
      return ConversationModel.fromJson(
          Map<String, dynamic>.from(conversationData));
    } else {
      return null; // إذا لم يتم العثور على المحادثة
    }
  }

  Future<void> updateAddChat(ConversationModel conversation) async {
    int id = conversation.id;
    final chatKey = 'chat_$id';

    // حول كائن ConversationModel إلى JSON أو Map وقم بتخزينه في الصندوق
    await _box.put(chatKey, conversation.toJson());
  }
}
