// في presentation/controllers/user_controller.dart

import 'dart:convert';
// import 'dart:ffi';

import 'package:eyes_care_chat_app_last/cahtapp/data/models/conversation_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/other_userModel.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/repositories/chat_repository_impl.dart';
import 'package:eyes_care_chat_app_last/cahtapp/domain/repositories/chat_repository.dart';
import 'package:eyes_care_chat_app_last/cahtapp/domain/serveses/pusher.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/domain/use_cases/chats_use_case.dart';
import 'package:eyes_care_chat_app_last/chat/data/hive_box/user_box.dart';
import 'package:eyes_care_chat_app_last/chat/data/models/user_model.dart';
import 'package:eyes_care_chat_app_last/chat/presentation/controllers/user_controller.dart';
import 'package:eyes_care_chat_app_last/core/network_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ConversationController extends GetxController {
  final UserController userController = UserController();
  NetworkInfo networkInfo = NetworkInfoImpl();
  // final ChatsUseCaseRequest chatsUseCaseRequest = ChatsUseCaseRequest();

  final ChatRepository chatRepository = ChatRepositoryImpl();

  // final SaveAllChats saveAllChats = SaveAllChats(ChatRepositoryImpl());

  // final GetAllChatsUseCase getAllChatsUseCase =
  //     GetAllChatsUseCase(ChatRepositoryImpl());

  PusherService pusherService = Get.find();

  var userId = 0.obs;

  AuthBox authBox = AuthBox();
  var selectedState = 'close'.obs;
  var currentIndex = 0.obs;
  var userType = ''.obs;
  var accessToken = ''.obs;
  var conversations = <ConversationModel>[].obs;
  var filteredConversations = <ConversationModel>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    getConversations();

   
    userId.value = await authBox.getUserId();
    print(userId.value);
    userType.value = await authBox.getUserType();
    accessToken.value = await authBox.getAuthToken();

  }

  @override
  void onReady() {
    super.onReady();
    // تنفيذ حدث عند فتح الشاشة (مشابه لـ onResume)
    print("ChatScreen is now ready and visible!");
  }

  Future<void> getConversations() async {
    conversations.clear();
    final user = await getCareentUser();

    await chatRepository.requestGetAllConversation(user.accessToken);

    final fetchedConversations =
        await chatRepository.GetAllConversationFromLocal();

    if (fetchedConversations != null) {
      // إضافة المحادثات الجديدة وترتيبها حسب آخر رسالة
      conversations.assignAll(fetchedConversations);
      changeState2(currentIndex.value);
    } else {
      print('no chats');
    }

    await startLisnar();
  }

  Future<void> startLisnar() async {
    if (await networkInfo.isConnected && conversations.isNotEmpty) {
      for (var i in conversations) {
        final id = i.id;

        if (pusherService.pusher.channels.containsKey('conversation-$id')) {
          try {
            pusherService.pusher.channels['conversation-$id']!.onEvent =
                (event) => onEvent(event);
          } catch (e) {
            print("ERROR: $e");
          }
        } else {
          try {
            await pusherService.pusher.subscribe(
                channelName: 'conversation-$id',
                onEvent: onEvent,
                onSubscriptionError: onSubscriptionError);
          } catch (e) {
            print("ERROR: $e");
          }
        }
      }
    }
  }

  Future<void> closeChat(ConversationModel conversationModel) async {
    showLoadingDialog();
    int result = await chatRepository.closeChat(
        conversationModel, accessToken.value);

    if (result == 1) {
      Get.back();

      showSendSnackbar();
    } else {
      showFildSnackbar('فشل', 'فشل اغلاق المحادثة . حاول مجددا');
    }
  }

  void closeChatDialog(ConversationModel conversationModel) {
    if (userType.value != 'doctor') {
      return;
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'اختر خيارًا',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('اغلاق المحادثة'),
                onPressed: () {
                  closeChat(conversationModel);
                  print('تم اغلاق : $conversationModel');
                  Get.back();
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.cancel),
                label: const Text('إلغاء'),
                onPressed: () {
                  Get.back(); // إغلاق الـ Dialog عند اختيار "إلغاء"
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLoadingDialog() {
    Get.dialog(
      AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20), // Spacing between progress indicator and text
            Text("يرجى الانتظار ...."),
          ],
        ),
      ),
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
    );
  }

  void onSubscriptionError(dynamic) {
    print('no connection or alrady sebsecrabd');
  }

  void onEvent(dynamic event) {
    print("onEvent: $event");
    final messageData = json.decode(event.data);

    String channelName = event.channelName.toString();
    RegExp regExp = RegExp(r'conversation-(\d+)');

    var match = regExp.firstMatch(channelName);

    if (match != null) {
      String conversationNumber = match.group(1)!;
      int covId = int.parse(conversationNumber);

      if (messageData['message'] != null) {
        final messageModel = MessageModel.fromJson(messageData['message']);
        updateConv(covId, messageModel);
      }
    }
  }

  void updateConv(int covId, MessageModel messageModel) {
    int index =
        conversations.indexWhere((conversation) => conversation.id == covId);

    if (index != -1) {
      // استبدال المحادثة القديمة بالمحادثة الجديدة
      conversations[index].lastMessage = messageModel;
      changeState2(currentIndex.value);
      print('تم استبدال المحادثة بنجاح');
    } else {
      print('لم يتم العثور على محادثة بـ id 4');
    }
  }

  void filterConversations(bool showOpenConversations) {
    filteredConversations.clear();

    if (showOpenConversations) {
      filteredConversations.value = conversations
          .where((conversation) => conversation.is_active == true)
          .toList();
    } else {
      filteredConversations.value = conversations
          .where((conversation) => conversation.is_active == false)
          .toList();
    }

    sortConversations();
  }

  void sortConversations() {
    filteredConversations.sort(
        (a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp));
  }

  void changeState2(int index) {
    currentIndex.value = index;
    if (index == 0) {
      filterConversations(true); // المحادثات المفتوحة
    } else {
      filterConversations(false); // المحادثات المغلقة
    }
  }

  // دالة لإضافة محادثة جديدة مع إعادة الترتيب
  void addConversation(ConversationModel conversation) {
    conversations.add(conversation);
    sortConversations();
  }

  
  void changeState(String state) {
    selectedState.value = state;
  }

  int selectIndex() {
    if (selectedState == 'close') {
      return 0;
    } else {
      return 1;
    }
  }

  MessageModel getLastMessageForConversation(int id) {
    final massege = filteredConversations[id].lastMessage;

    return massege;
  }

  OtherUserModel getOtherUserConversation(int id) {
    final otherUser = filteredConversations[id].otherUser;

    return otherUser;
  }

  void retutnListen(int id) async {
    if (pusherService.pusher.channels.containsKey('conversation-$id')) {
      pusherService.pusher.channels['conversation-$id']!.onEvent =
          (event) => onEvent(event);
    } else {
      print('lol');
    }
  }

  Future<UserModel> getCareentUser() async {
    return await userController.getUser();
  }

  void showSendSnackbar() {
    Get.snackbar(
      'تم بنجاح', // عنوان الـ Snackbar
      'تم اغلاق المحادثة بنجاح!', // محتوى الـ Snackbar
      snackPosition: SnackPosition.TOP, // تحديد ظهور الـ Snackbar في الأعلى
      backgroundColor: Colors.green, // لون الخلفية
      colorText: Colors.white, // لون النص
      borderRadius: 10, // حواف مستديرة
      margin: const EdgeInsets.all(16), // الهوامش حول الـ Snackbar
      duration: const Duration(seconds: 3), // مدة ظهور الـ Snackbar
    );
  }

  void showFildSnackbar(String tital, String body) {
    Get.snackbar(
      tital, // عنوان الـ Snackbar
      body, // محتوى الـ Snackbar
      snackPosition: SnackPosition.TOP, // تحديد ظهور الـ Snackbar في الأعلى
      backgroundColor: Color.fromARGB(207, 255, 44, 7),
      colorText: Colors.white, // لون النص
      borderRadius: 10, // حواف مستديرة
      margin: const EdgeInsets.all(16), // الهوامش حول الـ Snackbar
      duration: const Duration(seconds: 3), // مدة ظهور الـ Snackbar
    );
  }
}

