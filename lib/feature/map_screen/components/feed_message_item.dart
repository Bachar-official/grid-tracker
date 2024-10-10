import 'package:flutter/material.dart';
import 'package:grid_tracker/data/entity/message.dart';
import 'package:intl/intl.dart';

class FeedMessageItem extends StatelessWidget {
  final FeedMessage message;
  const FeedMessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('HHmmss').format(message.time);
    return Text(
      '$formattedTime      ${message.rawMessage}',
      textAlign: TextAlign.center,
    );
  }
}
