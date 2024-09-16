import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/conest/colors.dart';
import 'package:provider/presentaion/getx/Conversation_controller.dart';
import 'package:provider/presentaion/widget/category_selector.dart';
import 'package:provider/presentaion/widget/list_chat.dart';

class HomeChat extends StatelessWidget {
  final ConversationController controller = Get.put(ConversationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarChatHome(),
      body: Column(
        children: [
          CategorySelector(), // استدعاء عنصر CategorySelector
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListChats(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'محادثات مفتوحة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lock),
              label: 'محادثات مغلقة',
            ),
          ],
          currentIndex: controller.selectIndex(),
          onTap: (value) =>
              controller.changeState(value == 0 ? 'close' : 'open')),
    );
  }

  //  return GestureDetector(
  //                 onTap: () => Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (_) => ChatScreen(
  //                       user: chat.sender,
  //                     ),
  //                   ),
  //                 ),
  //                 child: Container(
  //                   margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
  //                   padding:
  //                       EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  //                   decoration: BoxDecoration(
  //                     color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,
  //                     borderRadius: BorderRadius.only(
  //                       topRight: Radius.circular(20.0),
  //                       bottomRight: Radius.circular(20.0),
  //                     ),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: <Widget>[
  //                       Row(
  //                         children: <Widget>[
  //                           CircleAvatar(
  //                             radius: 35.0,
  //                             backgroundImage: AssetImage(chat.sender.imageUrl),
  //                           ),
  //                           SizedBox(width: 10.0),
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: <Widget>[
  //                               Text(
  //                                 chat.sender.name,
  //                                 style: TextStyle(
  //                                   color: Colors.grey,
  //                                   fontSize: 15.0,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                               SizedBox(height: 5.0),
  //                               Container(
  //                                 width: MediaQuery.of(context).size.width * 0.45,
  //                                 child: Text(
  //                                   chat.text,
  //                                   style: TextStyle(
  //                                     color: Colors.blueGrey,
  //                                     fontSize: 15.0,
  //                                     fontWeight: FontWeight.w600,
  //                                   ),
  //                                   overflow: TextOverflow.ellipsis,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                       Column(
  //                         children: <Widget>[
  //                           Text(
  //                             chat.time,
  //                             style: TextStyle(
  //                               color: Colors.grey,
  //                               fontSize: 15.0,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           SizedBox(height: 5.0),
  //                           chat.unread
  //                               ? Container(
  //                                   width: 40.0,
  //                                   height: 20.0,
  //                                   decoration: BoxDecoration(
  //                                     color: Theme.of(context).primaryColor,
  //                                     borderRadius: BorderRadius.circular(30.0),
  //                                   ),
  //                                   alignment: Alignment.center,
  //                                   child: Text(
  //                                     'NEW',
  //                                     style: TextStyle(
  //                                       color: Colors.white,
  //                                       fontSize: 12.0,
  //                                       fontWeight: FontWeight.bold,
  //                                     ),
  //                                   ),
  //                                 )
  //                               : Text(''),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );

// class HomeChat extends StatelessWidget {
//   final ConversationController controller = Get.put(ConversationController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBarChatHome(),
//       body: Column(
//         children: [
//           CategorySelector(),
//           Expanded(
//             child: Obx(() {
//               return ListView.builder(
//                 itemCount: controller.filteredConversations.length,
//                 itemBuilder: (context, index) {
//                   final conversation = controller.filteredConversations[index];
//                   final lastMessage = controller.getLastMessageForConversation(conversation.converId);

//                   return ListTile(
//                     title: Text('محادثة مع ${conversation.doctorUid}'),
//                     subtitle: Text(
//                       'الحالة: ${conversation.state}\n'
//                       'آخر رسالة: ${lastMessage?.content ?? "لا توجد رسائل"}',
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

  AppBar appBarChatHome() {
    return AppBar(
      shadowColor: Colors.white,
      backgroundColor: Color(AppColor.primaryColor),
      leading: IconButton(
        icon: Icon(Icons.menu),
        iconSize: 30.0,
        color: Colors.white,
        onPressed: () {},
      ),
      title: Text(
        'الاستشارات',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }
}
