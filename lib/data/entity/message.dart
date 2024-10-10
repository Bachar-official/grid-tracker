import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:grid_tracker/utils/utils.dart';

Message parseMessage(String msg) {
  List<String> words = msg.split(' ');
  if (words.length == 3) {
    if (words[0] == 'CQ' && isCallSign(words[1])) {
      return CQMessage(rawMessage: msg, callsign: words[1]);
    }
    if (isCallSign(words[0]) && isCallSign(words[1]) && isQTH(words[2])) {
      return QTHMessage(rawMessage: msg, callsign: words[1]);
    }
    if (isCallSign(words[0]) && isCallSign(words[1]) && words[2] == '73') {
      return ByeMessage(rawMessage: msg, callsign: words[1]);
    }
    if (isCallSign(words[0]) &&
        isCallSign(words[1]) &&
        int.tryParse(words[2]) != null) {
      return PowerMessage(rawMessage: msg, callsign: words[1]);
    }
    return RegularMessage(rawMessage: msg, callsign: words[1]);
  }
  return RegularMessage(rawMessage: msg, callsign: words[1]);
}

abstract class Message {
  final String rawMessage;
  final String callsign;
  late final Key key;
  late final String? qth;
  Message({required this.rawMessage, required this.callsign});
  Marker? toMarker({Map<String, String>? callsignDict});
}

class FeedMessage extends Message {
  final DateTime time;
  FeedMessage({
    required super.rawMessage,
    required this.time,
    required super.callsign,
  });

  @override
  Marker? toMarker({Map<String, String>? callsignDict}) => null;

  FeedMessage.fromMessage(Message message)
      : time = DateTime.now(),
        super(rawMessage: message.rawMessage, callsign: message.callsign);
}

class CQMessage extends Message {
  CQMessage({required super.rawMessage, required super.callsign}) {
    super.key = Key(callsign);
    qth = '${rawMessage.split(' ')[2]}ll';
  }
  @override
  Marker? toMarker({Map<String, String>? callsignDict}) =>
      getMessageMarker(this, callsignDict: callsignDict);
}

class QTHMessage extends Message {
  QTHMessage({required super.rawMessage, required super.callsign}) {
    super.key = Key(callsign);
    qth = '${rawMessage.split(' ')[2]}ll';
  }
  @override
  Marker? toMarker({Map<String, String>? callsignDict}) =>
      getMessageMarker(this, callsignDict: callsignDict);
}

class ByeMessage extends Message {
  ByeMessage({required super.rawMessage, required super.callsign}) {
    super.key = Key(callsign);
    qth = null;
  }
  @override
  Marker? toMarker({Map<String, String>? callsignDict}) =>
      getMessageMarker(this, callsignDict: callsignDict);
}

class PowerMessage extends Message {
  PowerMessage({required super.rawMessage, required super.callsign}) {
    super.key = Key(callsign);
    qth = null;
  }
  @override
  Marker? toMarker({Map<String, String>? callsignDict}) =>
      getMessageMarker(this, callsignDict: callsignDict);
}

class RegularMessage extends Message {
  RegularMessage({required super.rawMessage, required super.callsign}) {
    super.key = Key(callsign);
    qth = null;
  }
  @override
  Marker? toMarker({Map<String, String>? callsignDict}) {
    return getMessageMarker(this, callsignDict: callsignDict);
  }
}
