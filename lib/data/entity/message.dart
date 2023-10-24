import 'package:flutter_map/flutter_map.dart';
import 'package:grid_tracker/utils/utils.dart';

Message parseMessage(String msg) {
  List<String> words = msg.split(' ');
  if (words.length == 3) {
    if (words[0] == 'CQ') {
      return CQMessage(rawMessage: msg);
    }
    if (isCallSign(words[0]) && isCallSign(words[1]) && isQTH(words[2])) {
      return QTHMessage(rawMessage: msg);
    }
    if (isCallSign(words[0]) && isCallSign(words[1]) && words[2] == '73') {
      return ByeMessage(rawMessage: msg);
    }
    if (isCallSign(words[0]) &&
        isCallSign(words[1]) &&
        int.tryParse(words[2]) != null) {
      return PowerMessage(rawMessage: msg);
    }
  }
  return RegularMessage(rawMessage: msg);
}

abstract class Message {
  final String rawMessage;
  Message({required this.rawMessage});
  Marker? toMarker({String? qth, Map<String, String>? callsignDict});
}

class CQMessage extends Message {
  CQMessage({required super.rawMessage});
  @override
  Marker? toMarker({String? qth, Map<String, String>? callsignDict}) {
    // TODO: implement toMarker
    throw UnimplementedError();
  }
}

class QTHMessage extends Message {
  QTHMessage({required super.rawMessage});
  @override
  Marker? toMarker({String? qth, Map<String, String>? callsignDict}) {
    // TODO: implement toMarker
    throw UnimplementedError();
  }
}

class ByeMessage extends Message {
  ByeMessage({required super.rawMessage});
  @override
  Marker? toMarker({String? qth, Map<String, String>? callsignDict}) {
    // TODO: implement toMarker
    throw UnimplementedError();
  }
}

class RegularMessage extends Message {
  RegularMessage({required super.rawMessage});
  @override
  Marker? toMarker({String? qth, Map<String, String>? callsignDict}) => null;
}

class PowerMessage extends Message {
  PowerMessage({required super.rawMessage});
  @override
  Marker? toMarker({String? qth, Map<String, String>? callsignDict}) {
    // TODO: implement toMarker
    throw UnimplementedError();
  }
}
