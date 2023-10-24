import 'package:flutter/material.dart';
import 'package:grid_tracker/data/entity/call_reason.dart';

void showSnackBar(
    GlobalKey<ScaffoldMessengerState> key, Color color, String message) {
  key.currentState!.showSnackBar(SnackBar(
    backgroundColor: color,
    content: Text(message),
  ));
}

Widget getMapIcon(CallReason? reason, {String? callsign}) {
  switch (reason) {
    case CallReason.service:
      return callsign != null
          ? Tooltip(
              message: callsign,
              child: const Icon(
                Icons.home,
                color: Colors.orange,
              ),
            )
          : const Icon(
              Icons.home,
              color: Colors.orange,
            );
    case CallReason.cq:
      return callsign != null
          ? Tooltip(
              message: callsign,
              child: const Icon(Icons.cell_tower, color: Colors.red),
            )
          : const Icon(Icons.cell_tower, color: Colors.red);
    case CallReason.call:
      return callsign != null
          ? Tooltip(
              message: callsign,
              child:
                  const Icon(Icons.record_voice_over, color: Colors.deepPurple),
            )
          : const Icon(Icons.record_voice_over, color: Colors.deepPurple);
    default:
      return const Icon(Icons.place, color: Colors.blue);
  }
}

CallReason? getReason(String message) {
  List<String> words = message.split(' ');
  if (words.length == 3) {
    if (message.startsWith('CQ')) {
      return CallReason.cq;
    }
    if (words[2].contains('+') || words[2].contains('-')) {
      return null;
    }
  }
  return CallReason.call;
}

String getQth(String message) {
  try {
    List<String> words = message.split(' ');
    if (words.length == 3) {
      if (message.startsWith('CQ')) {
        return words.last;
      }
      if (words[2].contains('+') || words[2].contains('-')) {
        return '';
      }
    }
    return words.last;
  } catch (e) {
    return '';
  }
}

String? getCallsign(String message) {
  try {
    List<String> words = message.split(' ');
    if (words.length == 3) {
      return words[1];
    } else {
      return words[2];
    }
  } catch (e) {
    return null;
  }
}
