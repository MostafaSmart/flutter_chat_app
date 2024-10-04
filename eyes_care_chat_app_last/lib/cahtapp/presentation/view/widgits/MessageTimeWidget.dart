import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTimeWidget extends StatelessWidget {
  final DateTime timestamp;

  MessageTimeWidget({required this.timestamp});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday = timestamp.year == now.year &&
        timestamp.month == now.month &&
        timestamp.day == now.day;

    String formattedTime;
    if (isToday) {
      formattedTime = DateFormat.jm().format(timestamp); // الوقت (12:3 PM)
    } else {
      formattedTime = DateFormat('d/M/yyyy').format(timestamp); // التاريخ (1/2/2024)
    }

    return Text(formattedTime, style: TextStyle(fontSize: 10));
  }
}
