import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/screen/home_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../presentation/controllers/user_controller.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الدخول')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'كلمة المرور'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await userController.login(
                    emailController.text, passwordController.text);
                    Get.to(() => HomeChat()); 
              },
              child: Text('تسجيل الدخول'),
            ),
          ],
        ),
      ),
    );
  }
}
