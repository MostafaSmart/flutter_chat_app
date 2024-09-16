import 'package:get/get.dart';
import 'package:provider/domain/entities/conver.dart';
import 'package:provider/domain/entities/massege.dart';
import 'package:provider/domain/entities/person_chat.dart';
import 'package:provider/presentaion/getx/messages_controller.dart';
import 'package:provider/presentaion/getx/user_controlar.dart'; // تأكد من استيراد ملف الكائنات بشكل صحيح

class ConversationController extends GetxController {
  var conversations = <Conver>[].obs;
  var filteredConversations = <Conver>[].obs;
  var selectedState = 'open'.obs;
  var _selectedIndex = 0.obs;
  final MessagesController messagesController = Get.put(MessagesController());

  final UserController userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    // هنا يمكنك جلب المحادثات من قاعدة البيانات
    fetchConversations();
  }

  void fetchConversations() {
    PersonChat? currentUser = getCerentUser();

    conversations.value = [
      Conver(
          converId: '1',
          doctorUid: 'doctor1',
          userUid: 'user1',
          state: 'open',
          startAt: DateTime.now().subtract(Duration(days: 1))),
      Conver(
          converId: '2',
          doctorUid: 'doctor2',
          userUid: 'user1',
          state: 'close',
          startAt: DateTime.now().subtract(Duration(days: 2))),
      Conver(
          converId: '3',
          doctorUid: 'doctor3',
          userUid: 'user1',
          state: 'open',
          startAt: DateTime.now().subtract(Duration(days: 3))),
      Conver(
          converId: '4',
          doctorUid: 'doctor4',
          userUid: 'user1',
          state: 'close',
          startAt: DateTime.now().subtract(Duration(days: 4))),
      Conver(
          converId: '4',
          doctorUid: 'doctor1',
          userUid: 'user2',
          state: 'open',
          startAt: DateTime.now().subtract(Duration(days: 5))),
      Conver(
          converId: '5',
          doctorUid: 'doctor2',
          userUid: 'user2',
          state: 'close',
          startAt: DateTime.now().subtract(Duration(days: 5))),
    ];

    if (currentUser!.type == 'user') {
      conversations.value = conversations
          .where((c) => c.userUid == currentUser.personUid)
          .toList();
    } else {
      conversations.value = conversations
          .where((c) => c.doctorUid == currentUser.personUid)
          .toList();
    }

    filterConversations();
  }

  void filterConversations() {
    filteredConversations.value =
        conversations.where((c) => c.state == selectedState.value).toList();

    sortConversationsByLastMessage();
  }

  PersonChat? getSender(String converUid) {
    PersonChat personChat = getCerentUser()!;
    Conver conve =
        filteredConversations.where((p0) => p0.converId == converUid).first;
    if (personChat.type == 'user') {
      return userController.getSender(conve.doctorUid);
    } else {
      return userController.getSender(conve.userUid);
    }
  }

  Masseges? getLastMessageForConversation(String converUid) {
    return messagesController.getLastMessage(converUid);
  }

  void sortConversationsByLastMessage() {
    filteredConversations.sort((a, b) {
      final lastMessageA = getLastMessageForConversation(a.converId);
      final lastMessageB = getLastMessageForConversation(b.converId);

      if (lastMessageA == null && lastMessageB == null) {
        return 0;
      } else if (lastMessageA == null) {
        return 1; // محادثة `b` تأتي قبل `a`
      } else if (lastMessageB == null) {
        return -1; // محادثة `a` تأتي قبل `b`
      } else {
        return lastMessageB.sendAt.compareTo(lastMessageA.sendAt);
      }
    });
  }

  PersonChat? getCerentUser() {
    return userController.getCerentUser();
  }

  void changeState(String state) {
    selectedState.value = state;

    if (state == "close") {
      _selectedIndex.value = 0;
    } else {
      _selectedIndex.value = 1;
    }
    filterConversations();
  }

  int selectIndex() {
    return _selectedIndex.value;
  }

  // void ching(int index) {
  //   _selectedIndex.value = index;

  // }
}
