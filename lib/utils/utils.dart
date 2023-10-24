import 'package:flutter/material.dart';
import 'package:grid_tracker/data/entity/call_reason.dart';
import 'package:grid_tracker/data/entity/message.dart';
import 'package:grid_tracker/feature/map_screen/components/faded_widget.dart';

void showSnackBar(
    GlobalKey<ScaffoldMessengerState> key, Color color, String message) {
  key.currentState!.showSnackBar(SnackBar(
    backgroundColor: color,
    content: Text(message),
  ));
}

bool isQTH(String str) {
  RegExp regex = RegExp(r'^[A-R]{2}\d{2}$');
  return regex.hasMatch(str);
}

bool isCallSign(String input) {
  RegExp regex =
      RegExp(r'^[A-Z0-9]{1,3}\d[A-Z0-9]{1,3}$', caseSensitive: false);

  return regex.hasMatch(input);
}

Widget getMapIcon(CallReason? reason,
    {String? callsign,
    required Key key,
    required Function(Key) onEnd,
    String? message}) {
  switch (reason) {
    case CallReason.message:
      return FadedWidget(
        duration: const Duration(seconds: 10),
        child: Card(
          child: Text(message ?? ''),
        ),
      );
    case CallReason.service:
      return callsign != null
          ? FadedWidget(
              onEnd: () => onEnd(key),
              child: Tooltip(
                message: callsign,
                child: const Icon(
                  Icons.home,
                  color: Colors.orange,
                ),
              ),
            )
          : FadedWidget(
              onEnd: () => onEnd(key),
              child: const Icon(
                Icons.home,
                color: Colors.orange,
              ),
            );
    case CallReason.cq:
      return callsign != null
          ? FadedWidget(
              onEnd: () => onEnd(key),
              child: Tooltip(
                message: callsign,
                child: const Icon(Icons.cell_tower, color: Colors.red),
              ),
            )
          : FadedWidget(
              onEnd: () => onEnd(key),
              child: const Icon(Icons.cell_tower, color: Colors.red));
    case CallReason.call:
      return callsign != null
          ? FadedWidget(
              onEnd: () => onEnd(key),
              child: Tooltip(
                message: callsign,
                child: const Icon(Icons.record_voice_over,
                    color: Colors.deepPurple),
              ),
            )
          : FadedWidget(
              onEnd: () => onEnd(key),
              child:
                  const Icon(Icons.record_voice_over, color: Colors.deepPurple),
            );
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
      return CallReason.message;
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
      if (words[2].contains('+') ||
          words[2].contains('-') ||
          int.tryParse(words[2]) != null) {
        return '';
      }
    }
    return words.last;
  } catch (e) {
    return '';
  }
}

void addCallsignRecord(String message, Map<String, String> map) {
  List<String> words = message.split(' ');
  if (words.length == 3 && words[0] == 'CQ') {
    map[words[1]] = words[2];
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
