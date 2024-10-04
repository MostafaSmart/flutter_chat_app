import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;

class LazyLoadFileWidget extends StatefulWidget {
  final String fileUrl;
  final double iconSize;

  const LazyLoadFileWidget({
    Key? key,
    required this.fileUrl,
    this.iconSize = 50.0,
  }) : super(key: key);

  @override
  _LazyLoadFileWidgetState createState() => _LazyLoadFileWidgetState();
}

class _LazyLoadFileWidgetState extends State<LazyLoadFileWidget> {
  bool _isFileDownloaded = false;
  String? _localFilePath;

  @override
  void initState() {
    super.initState();
    _checkIfFileExists();
  }

  // دالة للتحقق مما إذا كان الملف موجودًا بالفعل في التخزين المؤقت
  Future<void> _checkIfFileExists() async {
    try {
      // استخراج اسم الملف من URL
      String fileName = _getFileNameFromUrl(widget.fileUrl);

      // الحصول على دليل التخزين المؤقت
      var dir = await getApplicationDocumentsDirectory();
      String filePath = '${dir.path}/$fileName';
      File file = File(filePath);

      // إذا كان الملف موجودًا بالفعل
      if (await file.exists()) {
        setState(() {
          _isFileDownloaded = true;
          _localFilePath = filePath;
        });
      }
    } catch (e) {
      print('حدث خطأ أثناء التحقق من وجود الملف: $e');
    }
  }

  // استخراج اسم الملف من URL
  String _getFileNameFromUrl(String url) {
    return path.basename(Uri.parse(url).path);
  }

  // دالة لتحميل الملف وحفظه في التخزين المؤقت
  Future<void> _downloadAndSaveFile() async {
    try {
      String fileName = _getFileNameFromUrl(widget.fileUrl);

      var dir = await getApplicationDocumentsDirectory();
      String filePath = '${dir.path}/$fileName';
      File file = File(filePath);

      // إذا كان الملف موجودًا بالفعل، افتحه مباشرة
      if (await file.exists()) {
        OpenFile.open(filePath);
        return;
      }

      // تحميل الملف إذا لم يكن موجودًا
      var response = await http.get(Uri.parse(widget.fileUrl));

      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          _isFileDownloaded = true;
          _localFilePath = filePath;
        });

        // فتح الملف بعد التحميل
        OpenFile.open(filePath);
      } else {
        print('فشل تحميل الملف: ${response.statusCode}');
      }
    } catch (e) {
      print('حدث خطأ أثناء تحميل الملف: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isFileDownloaded && _localFilePath != null) {
          // إذا كان الملف موجودًا، افتحه
          OpenFile.open(_localFilePath!);
        } else {
          // إذا لم يكن الملف موجودًا، قم بتحميله
          _downloadAndSaveFile();
        }
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
              _isFileDownloaded ? Icons.insert_drive_file : Icons.download,
              size: widget.iconSize,
              color: _isFileDownloaded ? Colors.green : Colors.blue,
            ),
            const SizedBox(height: 8),
            Text(
              _getFileNameFromUrl(widget.fileUrl),
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
