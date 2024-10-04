
// import 'package:eyes_care_chat_app_last/cahtapp/presentation/controllers/conversations_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CategorySelector extends StatelessWidget {
//   final ConversationController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 90.0,
//         color: Theme.of(context).primaryColor,
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: [
//             Obx(() => GestureDetector(
//                 onTap: () => controller.changeState2(0),
//                 child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 20.0,
//                       vertical: 30.0,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           'محادثات مفتوحة',
//                           style: TextStyle(
//                             color: controller.selectedState.value == 'open'
//                                 ? Colors.white
//                                 : Colors.white60,
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Icon(
//                           Icons.abc_sharp,
//                           color: controller.selectedState.value == 'open'
//                               ? Colors.white
//                               : Colors.white60,
//                         )
//                       ],
//                     )))),

//                      Obx(() => GestureDetector(
//                 onTap: () => controller.changeState2(1),
//                 child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 20.0,
//                       vertical: 30.0,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           'محادثات مغلقة',
//                           style: TextStyle(
//                             color: controller.selectedState.value == 'close'
//                                 ? Colors.white
//                                 : Colors.white60,
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Icon(
//                           Icons.abc_sharp,
//                           color: controller.selectedState.value == 'close'
//                               ? Colors.white
//                               : Colors.white60,
//                         )
//                       ],
//                     )))),
//           ],
//         )


//         );
//   }
// }
