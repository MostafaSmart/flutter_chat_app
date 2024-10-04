import 'package:eyes_care_chat_app_last/cahtapp/presentation/controllers/conversations_controller.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/category_selector.dart';
import 'package:eyes_care_chat_app_last/cahtapp/presentation/view/widgits/list_chat.dart';
import 'package:eyes_care_chat_app_last/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeChat extends StatelessWidget {

  final ConversationController controller = Get.put(ConversationController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        
        appBar: appBarChatHome(),
        body: Column(
          children: [
            // CategorySelector(), // استدعاء عنصر CategorySelector
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
            currentIndex: controller.currentIndex.value, // العنصر المحدد افتراضيًا
            
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
           
             onTap: (index) {
        
        // المحادثات المفتوحة
        controller.changeState2(index);
      
             }
        )),
    );
  }

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
