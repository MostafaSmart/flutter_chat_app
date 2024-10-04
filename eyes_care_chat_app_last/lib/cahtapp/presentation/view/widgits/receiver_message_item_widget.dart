import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/MessageTimeWidget.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/cached_image_widget.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/lazy_load_image_widget.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/lazy_load_widget.dart';
import 'package:eyes_care_chat_app_last/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/masseges_contrtoller.dart';

class ReceiverMsgItemWidget extends StatelessWidget {
  ReceiverMsgItemWidget({
    super.key,
    required this.message,
  });
  final MessageController controller = Get.find();
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    // double width = Sizes.getWidth(context) / 2;
    // double  height= Sizes.getHeight(context) * 2;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CachedImageWidget(
        //   imgUrl: controller.conversationModel.otherUser.profile_picture != null
        //       ? controller.conversationModel.otherUser.profile_picture!
        //       : 'https://neweralive.na/wp-content/uploads/2024/06/lloyd-sikeba.jpg',
        //   radius: 100,
        //   height: 40,
        //   width: 40,
        // ),
        const SizedBox(
          width: 8,
        ),
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: Sizes.getWidth(context) / 2, // أقصى عرض للحاوية
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 208, 207, 207),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: message.file != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LazyLoadWidget(
                              url:
                             message.file!.toString(),
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                          ],
                        )
                      : Text(
                          message.content.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ),
                const SizedBox(height: 6),
                MessageTimeWidget(
                  timestamp: message.timestamp,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

