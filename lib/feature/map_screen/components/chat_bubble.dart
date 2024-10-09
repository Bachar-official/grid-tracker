import 'package:flutter/material.dart';

class OutBubble extends StatelessWidget {
  final String message;
  const OutBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.indigo.shade600,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(19),
          bottomRight: Radius.circular(19),
          topRight: Radius.circular(19),
        ),
      ),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
