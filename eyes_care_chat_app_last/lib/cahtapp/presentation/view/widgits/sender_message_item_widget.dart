import 'dart:io';

import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/controllers/masseges_contrtoller.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/MessageTimeWidget.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/cached_image_widget.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/file_preview_widget.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/lazy_load_image_widget.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/lazy_load_widget.dart';
import 'package:eyes_care_chat_app_last/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SenderMsgItemWidget extends StatelessWidget {
  SenderMsgItemWidget({
    super.key,
    required this.message,
  });
  final MessageController controller = Get.find();
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
 

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 75, 160, 246),
                    borderRadius:  BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: Sizes.getWidth(context) / 2, // الحد الأقصى للعرض
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // حالة: الرسالة تحتوي على ملف والصورة موجودة (تحقق من الملف)
                      if (message.file != null && message.isReceived == false && message.content != '.') ...[
                        GestureDetector(
                          onTap: () {
                            controller.showImageDialog(
                                flag: 1, imagePath: message.file!.toString());
                          },
                          child: File(message.file!.toString()).existsSync()
                              ? FilePreviewWidget(filePath: message.file!.toString(),) 
                              : Container(
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width / 2,
                                  color: Colors.grey,
                                  child: const Center(
                                    child: Text(
                                      'الصورة غير موجودة',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          message.content.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ] else if (message.file != null && message.isReceived == false && message.content == '.') ...[
                        GestureDetector(
                          onTap: () {
                            controller.showImageDialog(
                                flag: 1, imagePath: message.file!.toString());
                          },
                          child: File(message.file!.toString()).existsSync()
                              ? FilePreviewWidget(filePath: message.file!.toString(),) 
                     
                              : Container(
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width / 2,
                                  color: Colors.grey,
                                  child: const Center(
                                    child: Text(
                                      'الصورة غير موجودة',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 5),
                      ] else if (message.file != null && message.isReceived == true) ...[
                        LazyLoadWidget(
                          url: message.file!.toString(),
                          height: Sizes.getHeight(context) * 0.2,
                          width: Sizes.getWidth(context) / 2,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(height: 6),
                        if (message.content != '.')
                          Text(
                            message.content.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ] else ...[
                        Text(
                          message.content.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (message.isRead)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: 16,
                      ),
                    if (message.isReceived)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      )
                    else
                      GestureDetector(
                        onTap: () {
                          controller.reSendMessageDialog(message);
                        },
                        child: const Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 16,
                        ),
                      ),
                    const SizedBox(width: 40),
                    MessageTimeWidget(
                      timestamp: message.timestamp.toLocal(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

        ],
      ),
    );
  }
}


