import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/presentaion/getx/Conversation_controller.dart';

class CategorySelector extends StatelessWidget {
  final ConversationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90.0,
        color: Theme.of(context).primaryColor,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Obx(() => GestureDetector(
                onTap: () => controller.changeState('open'),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 30.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'محادثات مفتوحة',
                          style: TextStyle(
                            color: controller.selectedState.value == 'open'
                                ? Colors.white
                                : Colors.white60,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.abc_sharp,
                          color: controller.selectedState.value == 'open'
                              ? Colors.white
                              : Colors.white60,
                        )
                      ],
                    )))),

                     Obx(() => GestureDetector(
                onTap: () => controller.changeState('close'),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 30.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'محادثات مغلقة',
                          style: TextStyle(
                            color: controller.selectedState.value == 'close'
                                ? Colors.white
                                : Colors.white60,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.abc_sharp,
                          color: controller.selectedState.value == 'close'
                              ? Colors.white
                              : Colors.white60,
                        )
                      ],
                    )))),
          ],
        )

        //   child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Obx(() => ElevatedButton(
        //       onPressed: () => controller.changeState('open'),
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: Colors.transparent, // لإزالة الخلفية الافتراضية
        //         shadowColor: Colors.transparent, // لإزالة الظل
        //       ),
        //       child: Text(
        //         'محادثات مفتوحة',
        //         style: TextStyle(
        //           color: controller.selectedState.value == 'open' ? Colors.white : Colors.white60,
        //         ),
        //       ),
        //     )),
        //     SizedBox(width: 10),
        //     Obx(() => ElevatedButton(
        //       onPressed: () => controller.changeState('close'),
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: Colors.transparent, // لإزالة الخلفية الافتراضية
        //         shadowColor: Colors.transparent, // لإزالة الظل
        //       ),
        //       child: Text(
        //         'محادثات مغلقة',
        //         style: TextStyle(
        //           color: controller.selectedState.value == 'close' ? Colors.white : Colors.white60,
        //         ),
        //       ),
        //     )),
        //   ],
        // ),

        );
  }
}
