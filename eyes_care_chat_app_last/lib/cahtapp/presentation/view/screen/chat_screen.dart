import 'package:eyes_care_chat_app_last/cahtapp/data/models/conversation_model.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/other_userModel.dart';

import 'package:eyes_care_chat_app_last/cahtapp/presentation/controllers/masseges_contrtoller.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/masseg_widgit.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/receiver_message_item_widget.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/send_messeg.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/sender_message_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ChatScreen extends StatelessWidget {
  final ConversationModel conversationModel;
  final MessageController controller;
 
  // final ScrollController _scrollController =
  //     ScrollController(); // ScrollController

  ChatScreen({required this.conversationModel})
      : controller = Get.put(MessageController(conversationModel));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBarChatScreen(context, controller.getOtherUser()),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  child: Obx(() {
                    // Scroll to the bottom whenever messages change
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   if (_scrollController.hasClients && controller.messages.isNotEmpty) {
                    //     // Scroll to the last message after they are added
                    //     _scrollController..animateTo(
                    //       _scrollController.position.maxScrollExtent,
                    //       duration: const Duration(milliseconds: 300), // Duration of the animation
                    //       curve: Curves.easeInOut, // Type of curve for animation
                    //     );
                    //   }
                    // });
                    return ListView.builder(
                      controller:
                          controller.scrollController, // Attach the ScrollController
                      reverse: false,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 30),

                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        final bool isMe =
                            message.senderId == controller.senderId.value;
                        if (isMe) {
                          return SenderMsgItemWidget(message: message);
                        } else {
                          return ReceiverMsgItemWidget(message: message);
                        }
                      },
                    );
                  }),
                ),
              ),
            ),
            SendMessageWidget(),
          ],
        ),
      ),
    );
  }



  AppBar AppBarChatScreen(BuildContext context, OtherUserModel sender) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop(); // العودة إلى الشاشة السابقة
        },
      ),
      title: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage:
                AssetImage('assets/images/steven.jpg'), // صورة الطرف الثاني
            radius: 20.0,
          ),
          SizedBox(width: 10.0), // المسافة بين الصورة والاسم
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                sender.name, // اسم الطرف الثاني
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0), // المسافة بين الاسم وآخر ظهور
              Text(
                "last Seen " +
                    DateFormat('yyyy-MM-dd – kk:mm')
                        .format(conversationModel.createdAt),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
      elevation: 0, // إزالة ظل الـ AppBar إذا لزم الأمر
    );
  }

}







// class ChatScreem extends StatelessWidget {
//   final ConversationModel conversationModel;
//   final MessageController controller;
//   final TextEditingController _textController = TextEditingController();

//   ChatScreem({required this.conversationModel})
//       : controller = Get.put(MessageController(conversationModel));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Theme.of(context).primaryColor,
//         appBar: AppBarChatScreen(context, controller.getOtherUser()),
//         body: GestureDetector(
//             onTap: () => FocusScope.of(context).unfocus(),
//             child: Column(children: [
//               Expanded(
//                 child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10.0),
//                         topRight: Radius.circular(10.0),
//                       ),
//                     ),
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10.0),
//                           topRight: Radius.circular(10.0),
//                         ),
//                         child: Obx(() {
//                           return ListView.builder(
//                               reverse: true,
//                               padding: EdgeInsets.only(top: 15.0),
//                               itemCount: controller.messages.length,
//                               itemBuilder: (context, index) {
                               
//                                 final message = controller.messages[index];
//                                 final bool isMe = message.senderId ==
//                                     controller.senderId.value;
//                                 return _buildMessage(message, isMe, context);
//                               });
//                         }))),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 8.0),
//                 height: 70.0,
//                 color: Colors.white,
//                 child: Row(
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(Icons.photo),
//                       iconSize: 25.0,
//                       color: Theme.of(context).primaryColor,
//                       onPressed: () {},
//                     ),
//                     Expanded(
//                       child: TextField(
//                         controller: _textController,
//                         textCapitalization: TextCapitalization.sentences,
//                         onChanged: (value) {},
//                         decoration: InputDecoration.collapsed(
//                           hintText: 'كتابة رسالة',
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.send),
//                       iconSize: 25.0,
//                       color: Theme.of(context).primaryColor,
//                       onPressed: () {
//                         // إرسال الرسالة
//                         final content = _textController.text;
//                         if (content.isNotEmpty) {
//                           var vv = MessageModel(
//                             id: controller.senderId.value,
//                             conversationId: conversationModel.id,
//                             senderId: controller.senderId.value,
//                             content: content.toString(),
//                             isReceived: false,
//                             isRead: false,
//                             timestamp:
//                                 DateTime.now(),
//                             timeSince: 'therr hore',
//                             file: null,
//                           );

//                           controller.sendMassege(vv,controller.senderId.value,controller.resever.value,controller.accessToken.value);
//                           _textController.clear();
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               )
//               // _buildMessageComposer(context,messagesController)
//             ])));
//   }

//   _buildMessage(MessageModel message, bool isMe, BuildContext context) {
//     final Container msg = Container(
//       margin: isMe
//           ? EdgeInsets.only(
//               top: 8.0,
//               bottom: 8.0,
//               left: 150.0,
//             )
//           : EdgeInsets.only(
//               top: 8.0,
//               bottom: 8.0,
//             ),
//       padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
//       width: MediaQuery.of(context).size.width * 0.4,
//       decoration: BoxDecoration(
//         color: isMe ? Colors.cyan[600] : Color(AppColor.primaryColor),
//         borderRadius: isMe
//             ? BorderRadius.only(
//                 topLeft: Radius.circular(15.0),
//                 bottomLeft: Radius.circular(15.0),
//               )
//             : BorderRadius.only(
//                 topRight: Radius.circular(15.0),
//                 bottomRight: Radius.circular(15.0),
//               ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             message.content,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(height: 4.0),
//           Text(
//             DateFormat('yyyy-MM-dd – kk:mm').format(message.timestamp),
//             style: TextStyle(
//               color: Colors.blueGrey,
//               fontSize: 12.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//     if (isMe) {
//       return msg;
//     }
//     return Row(
//       children: <Widget>[
//         msg,
//         IconButton(
//           icon: true ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
//           iconSize: 30.0,
//           color: false ? Theme.of(context).primaryColor : Colors.blueGrey,
//           onPressed: () {},
//         )
//       ],
//     );
//   }

//   // _buildMessageComposer(
//   //     BuildContext context, MessagesController messagesController) {
//   //   final MessagesController messagesController =
//   //       Get.find<MessagesController>();

//   //   final user = conversationController.getCerentUser();
//   //   final userType = user!.type;
//   //   return Container(
//   //     padding: EdgeInsets.symmetric(horizontal: 8.0),
//   //     height: 70.0,
//   //     color: Colors.white,
//   //     child: Row(
//   //       children: <Widget>[
//   //         IconButton(
//   //           icon: Icon(Icons.photo),
//   //           iconSize: 25.0,
//   //           color: Theme.of(context).primaryColor,
//   //           onPressed: () {},
//   //         ),
//   //         Expanded(
//   //           child: TextField(
//   //             textCapitalization: TextCapitalization.sentences,
//   //             onChanged: (value) {},
//   //             decoration: InputDecoration.collapsed(
//   //               hintText: 'كتابة رسالة',
//   //             ),
//   //           ),
//   //         ),
//   //         IconButton(
//   //           icon: Icon(Icons.send),
//   //           iconSize: 25.0,
//   //           color: Theme.of(context).primaryColor,
//   //           onPressed: () {
//   //             // إرسال الرسالة
//   //             final content = messagesController.messageController.text;
//   //             if (content.isNotEmpty) {

//   //               messagesController.sendMessage(content, userType, converId);
//   //               messagesController.messageController
//   //                   .clear(); // مسح النص في TextField بعد الإرسال
//   //             }
//   //           },
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   AppBar AppBarChatScreen(BuildContext context, OtherUserModel sender) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back, color: Colors.black),
//         onPressed: () {
//           Navigator.of(context).pop(); // العودة إلى الشاشة السابقة
//         },
//       ),
//       title: Row(
//         children: <Widget>[
//           CircleAvatar(
//             backgroundImage: AssetImage('assets/images/steven.jpg'), // صورة الطرف الثاني
//             radius: 20.0,
//           ),
//           SizedBox(width: 10.0), // المسافة بين الصورة والاسم
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 sender.name, // اسم الطرف الثاني
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 4.0), // المسافة بين الاسم وآخر ظهور
//               Text(
//                 "last Seen " +
//                     DateFormat('yyyy-MM-dd – kk:mm').format(conversationModel.createdAt),
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontSize: 14.0,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       elevation: 0, // إزالة ظل الـ AppBar إذا لزم الأمر
//     );
//   }
// }
