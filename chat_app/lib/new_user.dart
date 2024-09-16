import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:provider/domain/entities/person_chat.dart';

class CreatePersonChatScreen extends StatefulWidget {
  @override
  _CreatePersonChatScreenState createState() => _CreatePersonChatScreenState();
}

class _CreatePersonChatScreenState extends State<CreatePersonChatScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  void _uploadPersonChat() async {
    String name = _nameController.text;
    String type = _typeController.text;

    if (name.isEmpty || type.isEmpty) {
      // عرض رسالة خطأ إذا كانت الحقول فارغة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both name and type')),
      );
      return;
    }

    // إنشاء مرجع document جديد للحصول على uid
    DocumentReference docRef = FirebaseFirestore.instance.collection('person').doc();

    // إنشاء كائن PersonChat جديد
    PersonChat newPersonChat = PersonChat(
      id: Random().nextInt(10000), // تعيين id عشوائي
      name: name,
      imgUrl: "assets/images/steven.jpg", // صورة ثابتة
      type: type,
      personUid: docRef.id, // استخدام uid من document
      token: "token",
      lastSeen: DateTime.now(), // الوقت الحالي
    );

    // رفع الكائن إلى فايرستور
    await docRef.set({
      'id': newPersonChat.id,
      'name': newPersonChat.name,
      'imgUrl': newPersonChat.imgUrl,
      'type': newPersonChat.type,
      'personUid': newPersonChat.personUid,
      'token': newPersonChat.token,
      'lastSeen': newPersonChat.lastSeen.toIso8601String(),
    });

    // إعادة ضبط الحقول بعد الرفع
    _nameController.clear();
    _typeController.clear();

    // عرض رسالة تأكيد
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PersonChat created and uploaded successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create PersonChat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadPersonChat,
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}

