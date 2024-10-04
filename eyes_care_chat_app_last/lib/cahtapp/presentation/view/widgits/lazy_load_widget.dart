import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/lazy_load_file_widget.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/lazy_load_image_widget.dart';
import 'package:flutter/material.dart';

class LazyLoadWidget extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final BoxFit fit;
  final double iconSize;

  const LazyLoadWidget({
    Key? key,
    required this.url,
    this.height = 200.0,
    this.width = 200.0,
    this.fit = BoxFit.cover,
    this.iconSize = 50.0,
  }) : super(key: key);

  // دالة للتحقق من ما إذا كان الـ URL يشير إلى صورة
  bool _isImageUrl(String url) {
    final imageExtensions = ['png', 'jpg', 'jpeg', 'gif', 'bmp'];
    final extension = url.split('.').last.toLowerCase();
    return imageExtensions.contains(extension);
  }

  // دالة للتحقق مما إذا كان الـ URL يشير إلى ملف PDF أو Word
  bool _isFileUrl(String url) {
    final fileExtensions = ['pdf', 'doc', 'docx'];
    final extension = url.split('.').last.toLowerCase();
    return fileExtensions.contains(extension);
  }

  @override
  Widget build(BuildContext context) {
    // تحقق من نوع الملف بناءً على الامتداد
    if (_isImageUrl(url)) {
      // إذا كان URL لصورة، اعرض LazyLoadImageWidget
      return LazyLoadImageWidget(
        imgUrl: url,
        height: height,
        width: width,
        fit: fit,
      );
    } else if (_isFileUrl(url)) {
      // إذا كان URL لملف، اعرض LazyLoadFileWidget
      return LazyLoadFileWidget(
        fileUrl: url,
        iconSize: iconSize,
      );
    } else {
      // إذا لم يكن صورة أو ملف معروف، اعرض رسالة أو عنصر بديل
      return const Center(
        child: Text("Unsupported file type"),
      );
    }
  }
}
