import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eyes_care_chat_app_last/cahtapp/domain/repositories/massegs_repository.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/screen/chat_screen.dart';
import 'package:eyes_care_chat_app_last/chat/data/hive_box/user_box.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:http_parser/http_parser.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/conversation_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/other_userModel.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/repositories/massegs_repository_impl.dart';
import 'package:eyes_care_chat_app_last/cahtapp/domain/serveses/pusher.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/domain/use_cases/masseges_use_case.dart';
import 'package:eyes_care_chat_app_last/chat/data/models/user_model.dart';
import 'package:eyes_care_chat_app_last/chat/presentation/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'dart:io';

// import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
// import 'package:mime/mime.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class MessageController extends GetxController {
  final ConversationModel conversationModel;

  final MassegRepository massegRepository = MassegRepositoryImpl();

  final ScrollController scrollController = ScrollController();
  MessageController(this.conversationModel);
  var messages = <MessageModel>[].obs;
  var senderId = 0.obs;
  var resever = 0.obs;

  final AuthBox authBox = AuthBox();

  var file = Rx<File?>(null);
  var accessToken = ''.obs;
  var imageFile = Rx<File?>(null);
  PusherService pusherService = Get.find();
  final UserController userController = UserController();
  final TextEditingController messageController = TextEditingController();
  @override
  Future<void> onInit() async {
    super.onInit();
    // final carrentuser = await getCareentUser();
    resever.value = conversationModel.otherUser.id;
    senderId.value = await authBox.getUserId();
    accessToken.value =await authBox.getAuthToken();

    await getConversations( accessToken.value);
    lisin();
  }

  // اختيار صورة من المعرض
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      _showImageDialog();
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'], // الامتدادات المسموح بها
    );

    if (result != null) {
      file.value = File(result.files.single.path!);

      _showFileDialog();
    }
  }

  void lisin() {
    var id = conversationModel.id;
    if (pusherService.pusher.channels.containsKey('conversation-$id')) {
      pusherService.pusher.channels['conversation-$id']!.onEvent =
          (event) => onEvent(event);
    }
  }

  void onEvent(dynamic event) {
    print("onEvent: $event");
    final messageData = json.decode(event.data);

    if (messageData['message'] != null) {
      final messageModel = MessageModel.fromJson(messageData['message']);

      saveRiceveMassege(messageModel);
      if (messageModel.senderId != senderId.value) {
        addMassege(messageModel);
      }
    }

    print(messageData['message']);
  }

  Future<void> getConversations(String accessToken) async {
    showLoadingDialog();
    await massegRepository.requestGetMassegsByConv(
        accessToken, conversationModel.id);

    final fetchedMessages = await massegRepository.GetMassegsByChatIDFromLocal(
        conversationModel.id);

    if (fetchedMessages.isNotEmpty) {
      messages.assignAll(fetchedMessages);

      sortConversations();
    }
    // Future.delayed(Duration(seconds: 6), () {
    Get.back();
    animateListToTheEnd();
    // });
  }

  Future<void> saveRiceveMassege(MessageModel messageModel) async {
    await massegRepository.saveNewMasseg(messageModel);
  }

  MessageModel preperNewMassegToSend(String content) {
    MessageModel messageModel = MessageModel(
        id: senderId.value,
        conversationId: conversationModel.id,
        senderId: senderId.value,
        content: content,
        isRead: false,
        isReceived: false,
        timestamp: DateTime.now(),
        timeSince: '0',
        file: null);

    if (imageFile.value != null) {
      messageModel.file = imageFile.value!.path.toString();
    } else if (file.value != null) {
      messageModel.file = file.value!.path.toString();
      print(file.value!.path.toString());
    }

    return messageModel;
  }

  Future<void> sendNewMassege(String content) async {
    final messageModel = preperNewMassegToSend(content);

    messages.add(messageModel);
    animateListToTheEnd();

    int index = messages.indexOf(messageModel);

    MessageModel massegg = await massegRepository.sendNewMasseg(
        messageModel, resever.value, accessToken.value);

    sortConversations();
    imageFile.value = null;
    file.value = null;
    if (massegg.isReceived == true) {
      messages.removeAt(index);
      messages.add(massegg);
      showSendSnackbar();

      sortConversations();
    } else {
      showFildSnackbar('فشل الارسال', 'فشل ارسال الرسالة , حاول مجددا');
    }
  }

  Future<void> addMassege(MessageModel? messageModel) async {
    if (messageModel != null) {
      messages.add(messageModel);
      sortConversations();
    } else {}
  }

  void sortConversations() {
    messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    animateListToTheEnd();
  }

  Future<UserModel> getCareentUser() async {
    return await userController.getUser();
  }

  OtherUserModel getOtherUser() {
    return conversationModel.otherUser;
  }



 

  Future<void> reSendMessege(MessageModel messageModel) async {
    if (messageModel.file != null) {
      if (!File(messageModel.file!.toString()).existsSync()) {
        showFildSnackbar('خطاء', 'الصورة لم تعد موجودة');

        return;
      }
    }

    MessageModel? newMasseg = await massegRepository.reSendMseg(
        messageModel, resever.value,accessToken.value);

    var index = messages.indexOf(messageModel);

    if (newMasseg.isReceived == true) {
      messages.removeAt(index);
      messages.add(newMasseg);
      showSendSnackbar();

      sortConversations();
    } else {
      showFildSnackbar('فشل الارسال', 'فشل ارسال الرسالة , حاول مجددا');
    }
  }

 animateListToTheEnd({int time = 500}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: time),
        curve: Curves.easeInOut,
      );
    });
  }
  void _showImageDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                // إضافة SingleChildScrollView هنا
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (imageFile.value != null)
                      Image.file(
                        imageFile.value!,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالتك هنا...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 46,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.send_sharp,
                                color: Colors.white,
                                size: 25,
                              ),
                              onPressed: () {
                                String messageText = '.';
                                if (messageController.text.isNotEmpty) {
                                  messageText = messageController.text;
                                }
                                sendNewMassege(messageText);
                                Get.back(); // إغلاق الـ Dialog بعد الإرسال
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  imageFile.value = null;
                  Get.back(); // إغلاق الـ Dialog عند الضغط على زر الإغلاق
                },
              ),
            ),
          ],
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

  void reSendMessageDialog(MessageModel message) {
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
                label: const Text('إعادة الإرسال'),
                onPressed: () {
                  reSendMessege(message);
                  print('تم إعادة الإرسال للرسالة: $message');
                  Get.back(); // لإغلاق الـ Dialog
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

  void showSendSnackbar() {
    Get.snackbar(
      'تم الإرسال', // عنوان الـ Snackbar
      'تم إرسال الرسالة بنجاح!', // محتوى الـ Snackbar
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

  void showImageDialog({required String imagePath, required int flag}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          height: Get.height * 0.6, // التحكم بحجم الـ Dialog
          child: Column(
            children: [
              Expanded(
                child: PhotoView(
                  imageProvider: flag == 0
                      ? CachedNetworkImageProvider(imagePath)
                      : FileImage(File(imagePath)) as ImageProvider,
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2.5,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Get.back(); // إغلاق الـ Dialog
                },
                icon: const Icon(Icons.close),
                label: const Text('إغلاق'),
              ),
            ],
          ),
        ),
      ),
    );
  }



  void _showFileDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (file.value != null)
                      Text(
                        'ملف : ${file.value!.path.split('/').last}', // عرض اسم الملف فقط
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالتك هنا...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 46,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.send_sharp,
                                color: Colors.white,
                                size: 25,
                              ),
                              onPressed: () {
                                String messageText = '.';
                                if (messageController.text.isNotEmpty) {
                                  messageText = messageController.text;
                                }
                                sendNewMassege(messageText);
                                Get.back(); // إغلاق الـ Dialog بعد الإرسال
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  file.value = null; // إعادة تعيين الملف إلى null
                  Get.back(); // إغلاق الـ Dialog عند الضغط على زر الإغلاق
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


}
