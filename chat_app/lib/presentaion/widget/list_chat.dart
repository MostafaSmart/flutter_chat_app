import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/presentaion/getx/Conversation_controller.dart';
import 'package:provider/presentaion/screen/chat_screen.dart';

class ListChats extends StatelessWidget {
  final ConversationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Expanded(
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
                  final lastMessage = controller
                      .getLastMessageForConversation(conversation.converId);
                  final sender = controller.getSender(conversation.converId);

                  return GestureDetector(
                    onTap: () {
                 Get.to(() => ChatScreem(converId: conversation.converId));

                    },
                    child: Container(
                      margin:
                          EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: lastMessage!.state == 'unread'
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
                            Row(children: <Widget>[
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage: AssetImage(sender!.imgUrl),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        lastMessage.content,
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ])
                            ]),
                            Column(
                              children: <Widget>[
                                Text(
                                  lastMessage.sendAt.timeZoneName,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                lastMessage.state == 'unread'
                                    ? Container(
                                        width: 40.0,
                                        height: 20.0,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
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
                          ]),
                    ),
                  );

                  // return ListTile(
                  //   title: Text(
                  //       'محادثة مع ${conversation.doctorUid}'),
                  //   subtitle:
                  //       Text('الحالة: ${conversation.state}'),
                  // );
                },
              );
            }),
          ),
        )));
  }
}
