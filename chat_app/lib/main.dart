// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/presentaion/screen/home_chat.dart';
// import 'firebase_options.dart';
import 'package:provider/conest/colors.dart';
// import 'package:provider/new_user.dart';
import 'package:provider/presentaion/getx/Conversation_controller.dart';
import 'package:provider/presentaion/getx/messages_controller.dart';
import 'package:provider/presentaion/getx/user_controlar.dart';
// import 'package:provider/presentaion/screen/home_chat.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
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
        home: Directionality(
            textDirection: TextDirection.rtl, child: HomeChat()),
      initialBinding: BindingsBuilder(() {
        Get.put(ConversationController());
        Get.put(UserController());
        Get.put(MessagesController()); // تسجيل ConversationController
      }),
    );
  }
}
