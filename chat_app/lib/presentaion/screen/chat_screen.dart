import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/conest/colors.dart';
import 'package:provider/domain/entities/massege.dart';
import 'package:provider/domain/entities/person_chat.dart';
import 'package:provider/presentaion/getx/Conversation_controller.dart';
import 'package:provider/presentaion/getx/messages_controller.dart';

class ChatScreem extends StatelessWidget {
  final String converId;

  ChatScreem({required this.converId});
  final ConversationController conversationController =
      Get.find<ConversationController>();
  final MessagesController messagesController = Get.find<MessagesController>();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = conversationController.getCerentUser();
    final sender = conversationController.getSender(converId);
    String userType = user!.type;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBarChatScreen(context, sender!),
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(children: [
              Expanded(
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
                          final messages = messagesController
                              .getMessagesForConversation(converId);
                          return ListView.builder(
                              reverse: true,
                              padding: EdgeInsets.only(top: 15.0),
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                final bool isMe = message.sender == userType;
                                return _buildMessage(message, isMe, context);
                              });
                        }))),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                height: 70.0,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.photo),
                      iconSize: 25.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {},
                        decoration: InputDecoration.collapsed(
                          hintText: 'كتابة رسالة',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      iconSize: 25.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        // إرسال الرسالة
                        final content = _textController.text;
                        if (content.isNotEmpty) {
                          var vv = Masseges(
                              converUid: converId,
                              sender: 'user',
                              type: 'text',
                              content: content.toString(),
                              state: 'read',
                              sendAt: DateTime.now()
                                  .subtract(Duration(minutes: 35)));
                          messagesController.addMessage(vv);
                          _textController.clear();
                        }
                      },
                    ),
                  ],
                ),
              )
              // _buildMessageComposer(context,messagesController)
            ])));
  }

  _buildMessage(Masseges message, bool isMe, BuildContext context) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 150.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: isMe ? Colors.cyan[600] : Color(AppColor.primaryColor),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.content,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            DateFormat('yyyy-MM-dd – kk:mm').format(message.sendAt),
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
        IconButton(
          icon: true ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: false ? Theme.of(context).primaryColor : Colors.blueGrey,
          onPressed: () {},
        )
      ],
    );
  }

  // _buildMessageComposer(
  //     BuildContext context, MessagesController messagesController) {
  //   final MessagesController messagesController =
  //       Get.find<MessagesController>();

  //   final user = conversationController.getCerentUser();
  //   final userType = user!.type;
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 8.0),
  //     height: 70.0,
  //     color: Colors.white,
  //     child: Row(
  //       children: <Widget>[
  //         IconButton(
  //           icon: Icon(Icons.photo),
  //           iconSize: 25.0,
  //           color: Theme.of(context).primaryColor,
  //           onPressed: () {},
  //         ),
  //         Expanded(
  //           child: TextField(
  //             textCapitalization: TextCapitalization.sentences,
  //             onChanged: (value) {},
  //             decoration: InputDecoration.collapsed(
  //               hintText: 'كتابة رسالة',
  //             ),
  //           ),
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.send),
  //           iconSize: 25.0,
  //           color: Theme.of(context).primaryColor,
  //           onPressed: () {
  //             // إرسال الرسالة
  //             final content = messagesController.messageController.text;
  //             if (content.isNotEmpty) {

  //               messagesController.sendMessage(content, userType, converId);
  //               messagesController.messageController
  //                   .clear(); // مسح النص في TextField بعد الإرسال
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  AppBar AppBarChatScreen(BuildContext context, PersonChat sender) {
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
            backgroundImage: AssetImage(sender.imgUrl), // صورة الطرف الثاني
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
                    DateFormat('yyyy-MM-dd – kk:mm').format(sender.lastSeen),
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
