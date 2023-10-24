import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:grid_tracker/data/entity/call_reason.dart';
import 'package:grid_tracker/feature/map_screen/map_state_holder.dart';
import 'package:grid_tracker/utils/utils.dart';
import 'package:gridlocator/gridlocator.dart';
import 'package:logger/logger.dart';
import 'package:latlong2/latlong.dart';

class MapManager {
  final Logger logger;
  final MapStateHolder holder;
  MapManager({required this.holder, required this.logger});
  final UniqueKey mapKey = UniqueKey();
  Map<String, String> callsigns = {};

  Future<void> setSocket(RawDatagramSocket socket) async {
    holder.setSocket(socket);
    if (holder.mapState.socket != null) {
      await for (var msg in holder.mapState.socket!) {
        var datagram = socket.receive();
        if (datagram != null) {
          parseData(datagram.data);
        }
      }
    }
  }

  void parseData(Uint8List byteArray) {
    String message = formatMessage(byteArray);
    if (byteArray.length == 124) {
      decodeServiceMessage(message);
    } else if (byteArray.length >= 60 && byteArray.length <= 70) {
      decodeMessage(message);
    }
  }

  String formatMessage(Uint8List list) {
    bool invalidSequence = false;

    List<int> sanitizedBytes = list
        .map((byte) {
          if (byte >= 32 && byte <= 126) {
            invalidSequence =
                false; // Сбрасываем флаг, если текущий байт в пределах ASCII
            return byte;
          } else {
            if (!invalidSequence) {
              invalidSequence =
                  true; // Устанавливаем флаг, если началась последовательность неправильных байтов
              return 44; // ASCII-код запятой
            } else {
              return 0; // Если байт внутри последовательности, пропускаем его
            }
          }
        })
        .where((byte) => byte != 0) // Убираем пропущенные байты
        .toList();

    return ascii.decode(sanitizedBytes, allowInvalid: true);
  }

  void decodeMessage(String message) {
    List<String> fields =
        message.split(',').where((str) => str.isNotEmpty).toList();
    logger.i('Got message ${fields.join(',')}');
    for (var field in fields) {
      if (field.contains(' ')) {
        addCallsignRecord(field, callsigns);
        final qth = getQth(field);
        if (qth != '') {
          addMarkerByQth(qth,
              reason: getReason(field), callsign: getCallsign(field));
        }
      }
    }
  }

  void decodeServiceMessage(String message) {
    List<String> fields =
        message.split(',').where((str) => str.isNotEmpty).toList();
    String qth = fields[7];
    addMarkerByQth(qth, reason: CallReason.service, callsign: fields[6]);
    // 2 - mode, 6 - callsign, 7 - QTH
  }

  void clearSocket() {
    if (holder.mapState.socket != null) {
      holder.mapState.socket!.close();
      holder.setSocket(null);
    }
  }

  void addMarkerByQth(String qth,
      {String? callsign, CallReason? reason, String? message}) {
    logger.d('Try do add marker with QTH $qth');
    if (qth.length == 4) {
      qth += 'll';
    }
    try {
      final point = Gridlocator.decode(qth);
      final key = Key(qth);
      Marker marker = Marker(
        key: key,
        point: LatLng(point.latitude, point.longitude),
        child: getMapIcon(reason,
            callsign: callsign,
            key: key,
            onEnd: holder.removeMarker,
            message: message),
      );
      holder.addMarker(marker);
    } on Exception catch (e, s) {
      logger.e('Error with $qth, ${e.toString()}', stackTrace: s);
    }
  }
}
