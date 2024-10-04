import 'package:eyes_care_chat_app_last/cahtapp/data/models/conversation_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
import 'package:eyes_care_chat_app_last/cahtapp/data/models/other_userModel.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/controllers/conversations_controller.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/screen/chat_screen.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/MessageTimeWidget.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ChatItemWidget extends StatelessWidget {
  final ConversationModel conversation;
  final MessageModel lastMessage;
  final OtherUserModel sender;
  final ConversationController controller = Get.find();
  ChatItemWidget({
    required this.conversation,
    required this.lastMessage,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ChatScreen(
                    conversationModel: conversation,
                  ))!
              .then((_) {
            controller.retutnListen(conversation.id);
            controller.getConversations();
          });
        },
        onLongPress: () {
          controller.closeChatDialog(conversation);
        },
        child: Container(
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: lastMessage.isRead == false &&
                    lastMessage.senderId != controller.userId.value
                ? Color(0xFFFFEFEE)
                : Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: conversation.otherUser.profile_picture != null
                        ? CachedImageWidget(
                            imgUrl: conversation.otherUser.profile_picture!,
                            radius: 29,
                            height: 40,
                            width: 40,
                          )
                        : CircleAvatar(
                            radius: 29.0,
                            backgroundImage:
                                AssetImage('assets/images/steven.jpg'),
                          ),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        sender.name,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          lastMessage.content == '.'
                              ? 'ملف'
                              : lastMessage.content,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  MessageTimeWidget(timestamp: lastMessage.timestamp),
                  SizedBox(height: 5.0),
                  lastMessage.isRead == false &&
                          lastMessage.senderId != controller.userId.value
                      ? Container(
                          width: 40.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'NEW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Text(''),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
