import 'dart:convert';
import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;
import 'package:eyes_care_chat_app_last/cahtapp/data/hive/masseg_hive.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:mime/mime.dart';

class MassegRemote {
  final masegBox = MassegHive();
  final http.Client client = http.Client();
  Future<List<MessageModel>> reqesutGetChat(
      String accessToken, int conversationId) async {
    final url = Uri.parse(
        'http://192.168.43.59:8000/api/chat/conversations/$conversationId');

    final response = await client.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final utf8DecodedBody = utf8.decode(response.bodyBytes);
      final massegsData = jsonDecode(utf8DecodedBody);

      final List<MessageModel> posts = (massegsData as List)
          .map((massdata) => MessageModel.fromJson(massdata))
          .toList();

      return posts;
    } else {
      print(accessToken);
      throw Exception('failed');
    }
  }




  Future<MessageModel?> sendNewMassegs(
      MessageModel massegs, int resever, String accessToken) async {
    
    if (massegs.file != null) {
      final mmesege =
          await sendMassegeFile(massegs, resever, accessToken);
      return mmesege;
    } else {
      final url =
          Uri.parse('http://192.168.43.59:8000/api/chat/messages/send/');

      final Map<String, dynamic> data = {
        'content': massegs.content,
        'receiver': resever,
        'file': null
      };
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken', // إذا كان لديك نظام مصادقة
      };
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final utf8DecodedBody = utf8.decode(response.bodyBytes);
        final massegsData = jsonDecode(utf8DecodedBody);
        final newMessage = MessageModel.fromJson(massegsData);
        print('sacsssssss_remote');

        return newMessage;
      } else {
        print('nulllllll_remote');

        return null;
      }
    }
  }



Future<MessageModel?> sendMassegeFile(MessageModel messageModel, int resever, String accessToken) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://192.168.43.59:8000/api/chat/messages/send/'));
  request.headers.addAll({
    'Authorization': 'Bearer $accessToken',
  });

  request.fields['content'] = messageModel.content;
  request.fields['receiver'] = resever.toString();

  try {
    // تحديد نوع الملف بناءً على الامتداد
    var mimeTypeData = lookupMimeType(messageModel.file!)?.split('/');
    if (mimeTypeData == null) {
      print("تعذر تحديد نوع الملف");
      return null;
    }

    // إنشاء ملف Multipart بناءً على نوع الملف (صورة أو مستند)
    var file = await http.MultipartFile.fromPath(
      'file',
      messageModel.file!,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    );

    request.files.add(file);

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        var responseData = await http.Response.fromStream(response);

        // فك ترميز النص باستخدام utf8.decode للتعامل مع النصوص العربية
        var decodedBody = utf8.decode(responseData.bodyBytes);

        // تحويل النص المفكوك إلى JSON
        var responseBody = jsonDecode(decodedBody);
        final newMessage = MessageModel.fromJson(responseBody);

        print('sacsssssss_remote:');
        print(newMessage);
        return newMessage;
      }
    } catch (e) {
      print("خطأ أثناء إرسال الطلب: $e");
    }
  } catch (e) {
    print("خطأ في تحديد MIME type: $e");
  }

  return null;
}


  // Future<MessageModel?> sendMassegeFile(MessageModel messageModel,
  //     int resever, String accessToken) async {
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('http://192.168.43.59:8000/api/chat/messages/send/'));
  //   request.headers.addAll({
  //     'Authorization': 'Bearer $accessToken',
  //   });

  //   request.fields['content'] = messageModel.content;
  //   request.fields['receiver'] = resever.toString();

  //   try {
  //     var mimeTypeData =
  //         lookupMimeType(imageFile.value!.path, headerBytes: [0xFF, 0xD8])
  //             ?.split('/');
  //     var file = await http.MultipartFile.fromPath(
  //       'file',
  //       imageFile.value!.path,
  //       contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
  //     );

  //     request.files.add(file);

  //     try {
  //       var response = await request.send();
  //       if (response.statusCode == 201) {
  //         var responseData = await http.Response.fromStream(response);

  //         // فك ترميز النص باستخدام utf8.decode للتعامل مع النصوص العربية
  //         var decodedBody = utf8.decode(responseData.bodyBytes);

  //         // تحويل النص المفكوك إلى JSON
  //         var responseBody = jsonDecode(decodedBody);
  //         final newMessage = MessageModel.fromJson(responseBody);

  //         print('sacsssssss_remote:');

  //         print(newMessage);
  //         return newMessage;
  //       }
  //     } catch (e) {}
  //   } catch (e) {}

  //   return null;
  // }


}
