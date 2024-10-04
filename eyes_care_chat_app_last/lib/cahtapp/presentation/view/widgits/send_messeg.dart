// import 'dart:developer';
import 'dart:io';

// import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/controllers/masseges_contrtoller.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/app_text_form_field.dart';
import 'package:eyes_care_chat_app_last/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({super.key});

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  File? currentSelectedImage;

  File? currentAudioFile;
  File? currentSelectedFile;
  TextEditingController messageController = TextEditingController();

  bool showAudioRecorder = false;
  final MessageController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox.shrink(),
        Container(
          padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 28),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
          child: Row(
            children: [
              Expanded(
                child: AppTextFormField(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  horizontalPadding: 0,
                  hintText: "اكتب رسالة",
                  textInputType: TextInputType.text,
                  controller: messageController,
                  borderRadius: 15,
                  backgroundColor: const Color.fromARGB(255, 239, 247, 252),
                  suffixIcon: SizedBox(
                    width: Sizes.getWidth(context) * 0.16,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            controller.pickImage();
                          },
                          child: const Icon(
                            Icons.image,
                            color: Colors.blueAccent,
                            size: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            onTap: () async {
                              controller.pickFile();
                            },
                            child: const Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                              size: 25,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
             

              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
       

                  if (messageController.text.isNotEmpty) {
                    String content = messageController.text;

                    controller.sendNewMassege(content);
                    messageController.clear();
                  }
                },
                child: Container(
                  height: 46,
                  width: 46,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.send_sharp,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
