import 'package:eyes_care_chat_app_last/cahtapp/presentation/controllers/conversations_controller.dart';

import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/chat_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ListChats extends StatelessWidget{
  final ConversationController controller = Get.find();



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Obx(() {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.filteredConversations.length,
              itemBuilder: (context, index) {
                final conversation = controller.filteredConversations[index];
                final lastMessage = controller.getLastMessageForConversation(index);
                final sender = controller.getOtherUserConversation(index);

                return ChatItemWidget(
                  conversation: conversation,
                  lastMessage: lastMessage,
                  sender: sender,
                  
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

  // Column buildConversationRow(
  //     String name, String message, String filename, int msgCount) {
  //   return Column(
  //     children: [
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Row(
  //             children: [
  //               UserAvatar(filename: filename),
  //               const SizedBox(
  //                 width: 15,
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     name,
  //                     style: const TextStyle(color: Colors.grey),
  //                   ),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   Text(
  //                     message,
  //                     style: const TextStyle(color: Colors.black),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(right: 25, top: 5),
  //             child: Column(
  //               children: [
  //                 const Text(
  //                   '16:35',
  //                   style: TextStyle(fontSize: 10),
  //                 ),
  //                 const SizedBox(
  //                   height: 15,
  //                 ),
  //                 if (msgCount > 0)
  //                   CircleAvatar(
  //                     radius: 7,
  //                     backgroundColor: const Color(0xFF27c1a9),
  //                     child: Text(
  //                       msgCount.toString(),
  //                       style:
  //                           const TextStyle(fontSize: 10, color: Colors.white),
  //                     ),
  //                   )
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //       const Divider(
  //         indent: 70,
  //         height: 20,
  //       )
  //     ],
  //   );
  // }

