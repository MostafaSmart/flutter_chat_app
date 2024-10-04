import 'package:eyes_care_chat_app_last/cahtapp/domain/serveses/pusher.dart';
import 'package:eyes_care_chat_app_last/chat/presentation/view/login_view.dart';
import 'package:eyes_care_chat_app_last/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('authBox');
  await Hive.openBox('chats');
  


  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
   Get.put(PusherService());

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(AppColor.primaryColor),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Color(AppColor.primaryColor)),
        useMaterial3: true,
      ),
      home:
          Directionality(textDirection: TextDirection.rtl, child: LoginView()),
          // initialBinding: BindingsBuilder(() {
      //   // Get.put(LoginController());
    
      //   // Get.put(ConversationController());
      //   // Get.put(UserController());
      //   // Get.put(MessagesController()); // تسجيل ConversationController
      // }),
    );
  }
}


// PUSHER_APP_ID = '1861904'         
// PUSHER_KEY = '6c5bc3a240a5017e7aac'              
// PUSHER_SECRET = '3c8d562b800fbe10857e'         
// PUSHER_CLUSTER = 'ap1'       

