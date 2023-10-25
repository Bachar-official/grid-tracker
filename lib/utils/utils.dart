import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:grid_tracker/data/entity/message.dart';
import 'package:grid_tracker/feature/map_screen/components/faded_widget.dart';
import 'package:gridlocator/gridlocator.dart';
import 'package:latlong2/latlong.dart';

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
      RegExp(r'^[A-Za-z0-9]{1,3}\d?[\/A-Za-z0-9]*$', caseSensitive: false);

  return regex.hasMatch(input);
}

Widget? getMessageWidget(Message message) {
  switch (message.runtimeType) {
    case CQMessage:
      return FadedWidget(
        message: message.rawMessage,
        child: Tooltip(
          key: message.key,
          message: message.callsign,
          child: const Icon(Icons.cell_tower, color: Colors.red),
        ),
      );
    case QTHMessage:
      return FadedWidget(
        message: message.rawMessage,
        child: Tooltip(
          key: message.key,
          message: message.callsign,
          child: const Icon(Icons.place, color: Colors.blue),
        ),
      );
    case ByeMessage:
      return FadedWidget(
        message: message.rawMessage,
        child: Tooltip(
          key: message.key,
          message: message.callsign,
          child: const Icon(Icons.waving_hand, color: Colors.grey),
        ),
      );
    case PowerMessage:
      return FadedWidget(
        message: message.rawMessage,
        child: Tooltip(
          key: message.key,
          message: message.callsign,
          child: const Icon(Icons.volume_up, color: Colors.brown),
        ),
      );
    case RegularMessage:
      return FadedWidget(
        message: message.rawMessage,
        child: Tooltip(
          key: message.key,
          message: message.callsign,
          child: const Icon(Icons.message, color: Colors.green),
        ),
      );
    default:
      return null;
  }
}

Marker? getMessageMarker(Message message, {Map<String, String>? callsignDict}) {
  if (message.qth != null) {
    try {
      final point = Gridlocator.decode(message.qth!);
      return Marker(
          key: UniqueKey(),
          point: LatLng(point.latitude, point.longitude),
          child: getMessageWidget(message)!);
    } catch (e) {
      return null;
    }
  }
  if (callsignDict != null && callsignDict.containsKey(message.callsign)) {
    final point = Gridlocator.decode(callsignDict[message.callsign]!);
    return Marker(
        key: UniqueKey(),
        point: LatLng(point.latitude, point.longitude),
        child: getMessageWidget(message)!);
  }
  return null;
}

void addCallsignRecord(String message, Map<String, String> map) {
  List<String> words = message.split(' ');
  if (words.length == 3 &&
      words[0] == 'CQ' &&
      isCallSign(words[1]) &&
      isQTH(words[2])) {
    map[words[1]] = '${words[2]}ll';
  }
  if (isCallSign(words[0]) && isCallSign(words[1]) && isQTH(words[2])) {
    map[words[1]] = '${words[2]}ll';
  }
}
