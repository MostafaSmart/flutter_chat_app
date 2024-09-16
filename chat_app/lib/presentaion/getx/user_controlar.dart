import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/domain/entities/person_chat.dart';

class UserController extends GetxController {
  var person_chat = <PersonChat>[].obs;

  @override
  void onInit() {
    super.onInit();
    // هنا يمكنك جلب الرسائل من قاعدة البيانات
    fetchUsers();
  }

  void fetchUsers() {
    // توليد قائمة رسائل افتراضية
    person_chat.value = [
      PersonChat(
          id: 1,
          name: 'مصطفى',
          type: 'doctor',
          imgUrl: 'assets/images/steven.jpg',
          personUid: 'doctor1',
          token: 'token',
          lastSeen: DateTime.now().subtract(Duration(hours: 1))),
      PersonChat(
          id: 2,
          name: 'بشار',
          type: 'doctor',
          imgUrl: 'assets/images/sophia.jpg',
          personUid: 'doctor2',
          token: 'token',
          lastSeen: DateTime.now().subtract(Duration(hours: 2))),
      PersonChat(
          id: 2,
          name: 'محمد',
          type: 'doctor',
          imgUrl: 'assets/images/john.jpg',
          personUid: 'doctor3',
          token: 'token',
          lastSeen: DateTime.now().subtract(Duration(minutes: 45))),
      PersonChat(
          id: 2,
          name: 'مالك',
          type: 'doctor',
          imgUrl: 'assets/images/john.jpg',
          personUid: 'doctor4',
          token: 'token',
          lastSeen: DateTime.now().subtract(Duration(minutes: 45))),
      PersonChat(
          id: 3,
          name: 'هاني',
          type: 'user',
          imgUrl: 'assets/images/greg.jpg',
          personUid: 'user1',
          token: 'token',
          lastSeen: DateTime.now().subtract(Duration(hours: 3))),
      PersonChat(
          id: 1,
          name: 'زايد',
          type: 'user',
          imgUrl: 'assets/images/james.jpg',
          personUid: 'user2',
          token: 'token',
          lastSeen: DateTime.now().subtract(Duration(minutes: 30))),
    ];
  }

  PersonChat? getCerentUser() {
    return person_chat.where((msg) => msg.personUid == 'user1').first;
  }

  PersonChat? getSender(String personUid) {
    return person_chat.where((msg) => msg.personUid == personUid).first;
  }

  // Masseges? getUserByID(String userId) {
  //   // الحصول على آخر رسالة مرتبطة بالمحادثة
  //   return messages
  //       .where((msg) => msg.converUid == converUid)
  //       .toList()
  //       .last;
  // }
}
