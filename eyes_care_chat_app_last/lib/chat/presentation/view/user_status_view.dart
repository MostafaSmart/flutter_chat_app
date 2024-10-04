// في presentation/views/user_status_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentation/controllers/user_controller.dart';
class UserStatusView extends StatelessWidget {
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('بيانات المستخدم')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await userController.loadUser(); // جلب بيانات المستخدم عند الضغط على الزر
                Get.defaultDialog(
                  title: 'بيانات المستخدم',
                  content: Column(
                    children: [
                      Text('اسم المستخدم: ${userController.user.value?.firstName} ${userController.user.value?.lastName}'),
                      Text('البريد الإلكتروني: ${userController.user.value?.email}'),
                    ],
                  ),
                  confirm: ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text('إغلاق'),
                  ),
                );
              },
              child: Text('عرض بياناتي'),
            ),
          ],
        ),
      ),
    );
  }
}
