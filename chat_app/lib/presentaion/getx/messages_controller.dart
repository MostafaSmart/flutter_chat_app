import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/domain/entities/massege.dart';

class MessagesController extends GetxController {
  var messages = <Masseges>[].obs;
  var messageController = TextEditingController(); // للتحكم في TextField

  @override
  void onInit() {
    super.onInit();
    // هنا يمكنك جلب الرسائل من قاعدة البيانات
    fetchMessages();
  }

  void fetchMessages() {
    // توليد قائمة رسائل افتراضية
    messages.value = [
      Masseges(converUid: '1', sender: 'doctor', type: 'text', content: 'رسالة 1', state: 'unread', sendAt: DateTime.now().subtract(Duration(hours: 1))),
      
      Masseges(converUid: '1', sender: 'doctor', type: 'text', content: 'رسالة 2', state: 'unread', sendAt: DateTime.now().subtract(Duration(hours: 2))),
      Masseges(converUid: '1', sender: 'user', type: 'text', content: 'رسالة 3', state: 'read', sendAt: DateTime.now().subtract(Duration(hours: 2))),

      
      Masseges(converUid: '1', sender: 'user', type: 'text', content: 'رسالة 4', state: 'read', sendAt: DateTime.now().subtract(Duration(hours: 2))),
      Masseges(converUid: '2', sender: 'user', type: 'text', content: 'رسالة 5', state: 'read', sendAt: DateTime.now().subtract(Duration(hours: 3))),
      Masseges(converUid: '2', sender: 'user', type: 'text', content: 'رسالة 6', state: 'read', sendAt: DateTime.now().subtract(Duration(minutes: 30))),
      Masseges(converUid: '2', sender: 'doctor', type: 'text', content: 'رسالة 7', state: 'read', sendAt: DateTime.now().subtract(Duration(minutes: 45))),
    
     Masseges(
          converUid: '2',
          sender: 'user',
          type: 'text',
          content: 'رسالة 6',
          state: 'unread',
          sendAt: DateTime.now().subtract(Duration(minutes: 30))),
      Masseges(
          converUid: '2',
          sender: 'doctor',
          type: 'text',
          content: 'رسالة 7',
          state: 'unread',
          sendAt: DateTime.now().subtract(Duration(minutes: 45))),
      Masseges(
          converUid: '2',
          sender: 'doctor',
          type: 'text',
          content: 'رسالة 8',
          state: 'unread',
          sendAt: DateTime.now().subtract(Duration(minutes: 50))),
      Masseges(
          converUid: '2',
          sender: 'user',
          type: 'text',
          content: 'رسالة 9',
          state: 'unread',
          sendAt: DateTime.now().subtract(Duration(minutes: 55))),

      // رسائل لـ converUid = 3
      Masseges(
          converUid: '3',
          sender: 'doctor',
          type: 'text',
          content: 'رسالة 10',
          state: 'sent',
          sendAt: DateTime.now().subtract(Duration(minutes: 20))),
      Masseges(
          converUid: '3',
          sender: 'user',
          type: 'text',
          content: 'رسالة 11',
          state: 'read',
          sendAt: DateTime.now().subtract(Duration(minutes: 25))),
      Masseges(
          converUid: '3',
          sender: 'doctor',
          type: 'text',
          content: 'رسالة 12',
          state: 'read',
          sendAt: DateTime.now().subtract(Duration(minutes: 40))),
      Masseges(
          converUid: '3',
          sender: 'doctor',
          type: 'text',
          content: 'رسالة 13',
          state: 'read',
          sendAt: DateTime.now().subtract(Duration(minutes: 45))),

      // رسائل لـ converUid = 4
      Masseges(
          converUid: '4',
          sender: 'doctor',
          type: 'text',
          content: 'رسالة 14',
          state: 'read',
          sendAt: DateTime.now().subtract(Duration(minutes: 15))),
      Masseges(
          converUid: '4',
          sender: 'user',
          type: 'text',
          content: 'رسالة 15',
          state: 'unread',
          sendAt: DateTime.now().subtract(Duration(minutes: 20))),
      Masseges(
          converUid: '4',
          sender: 'doctor',
          type: 'text',
          content: 'رسالة 16',
          state: 'unread',
          sendAt: DateTime.now().subtract(Duration(minutes: 35))),
      Masseges(
          converUid: '4',
          sender: 'doctor',
          type: 'text',
          content: 'رسالة 17',
          state: 'unread',
          sendAt: DateTime.now().subtract(Duration(minutes: 40))),

      // رسائل لـ converUid = 5
      Masseges(
          converUid: '5',
          sender: 'doctor',
          type: 'text',
          content: 'رسالة 18',
          state: 'unread',
          sendAt: DateTime.now().subtract(Duration(minutes: 10))),
      Masseges(
          converUid: '5',
          sender: 'user',
          type: 'text',
          content: 'رسالة 19',
          state: 'unread',
          sendAt: DateTime.now().subtract(Duration(minutes: 15))),
      Masseges(
          converUid: '5',
          sender: 'doctor',
          type: 'text',
          content: 'رسالة 20',
          state: 'read',
          sendAt: DateTime.now().subtract(Duration(minutes: 30))),
      Masseges(
          converUid: '5',
          sender: 'doctor',
          type: 'text',
          content: 'رسالة 21',
          state: 'read',
          sendAt: DateTime.now().subtract(Duration(minutes: 35))),
    
    
    
    
    ];
  }
   void addMessage(Masseges newMessage) {
    messages.add(newMessage);
    // الرسائل ستظهر في الوقت الحقيقي عند إضافتها إلى القائمة
  }

    List<Masseges> getMessagesForConversation(String converUid) {
    // الحصول على الرسائل الخاصة بالمحادثة وترتيبها حسب sendAt
    return messages
         .where((msg) => msg.converUid == converUid)
      .toList()
      ..sort((a, b) => a.sendAt.compareTo(b.sendAt))
      ..reversed.toList(); // عكس ترتيب القائمة
  }

  Masseges? getLastMessage(String converUid) {
    // الحصول على آخر رسالة مرتبطة بالمحادثة
    return messages
        .where((msg) => msg.converUid == converUid)
        .toList()
        .last;
  }
}
