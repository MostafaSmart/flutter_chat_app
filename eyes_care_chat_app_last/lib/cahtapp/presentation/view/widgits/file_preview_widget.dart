import 'dart:io';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/controllers/masseges_contrtoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;

class FilePreviewWidget extends StatelessWidget {
  final String filePath;
  final double iconSize;

   FilePreviewWidget({
    Key? key,
    required this.filePath,
    this.iconSize = 50.0,
  }) : super(key: key);

  final MessageController controller = Get.find();
  // دالة للتحقق من ما إذا كان المسار يشير إلى صورة
  bool _isImageFile(String filePath) {
    final imageExtensions = ['png', 'jpg', 'jpeg', 'gif', 'bmp'];
    final extension = path.extension(filePath).toLowerCase();
    return imageExtensions.contains(extension.replaceAll('.', ''));
  }

  // دالة للتحقق من ما إذا كان المسار يشير إلى ملف PDF أو Word
  bool _isFile(String filePath) {
    final fileExtensions = ['pdf', 'doc', 'docx'];
    final extension = path.extension(filePath).toLowerCase();
    return fileExtensions.contains(extension.replaceAll('.', ''));
  }

  @override
  Widget build(BuildContext context) {
    // إذا كان الملف صورة، اعرضه
    if (_isImageFile(filePath)) {
      return GestureDetector(
        onTap: () {
          // استدعاء دالة showImageDialog مع وضع 1
          controller.showImageDialog(imagePath:filePath, flag:1);
        },
        child: Image.file(
          File(filePath),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width / 2,
          fit: BoxFit.fill,
        ),
      );
    } else if (_isFile(filePath)) {
      // إذا كان الملف PDF أو Word، اعرض التصميم الخاص بالملفات
      return GestureDetector(
        onTap: () {
          // فتح الملف باستخدام التطبيقات المتاحة
          OpenFile.open(filePath);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Icon(
                Icons.insert_drive_file,
                size: iconSize,
                color: Colors.green,
              ),
              const SizedBox(height: 8),
              Text(
                path.basename(filePath), // اسم الملف
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      // إذا كان نوع الملف غير مدعوم
      return const Center(
        child: Text("Unsupported file type"),
      );
    }
  }
}
