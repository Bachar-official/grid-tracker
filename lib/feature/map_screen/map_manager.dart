import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grid_tracker/data/entity/message.dart';
import 'package:grid_tracker/feature/map_screen/map_state_holder.dart';
import 'package:grid_tracker/utils/utils.dart';
import 'package:logger/logger.dart';

class MapManager {
  final Logger logger;
  final MapStateHolder holder;
  MapManager({required this.holder, required this.logger});
  final UniqueKey mapKey = UniqueKey();
  Map<String, String> callsigns = {};

  Future<void> setSocket(RawDatagramSocket socket) async {
    holder.setSocket(socket);
    if (holder.mapState.socket != null) {
      // await for (var msg in holder.mapState.socket!) {
      //   var datagram = socket.receive();
      //   if (datagram != null) {
      //     parseData(datagram.data);
      //   }
      // }
      socket.listen((_) {
        var datagram = socket.receive();
        if (datagram != null) {
          parseData(datagram.data);
        }
      });
    }
  }

  void parseData(Uint8List byteArray) {
    String message = formatMessage(byteArray);
    if (byteArray.length >= 60 && byteArray.length <= 70) {
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
    for (var field in fields) {
      if (field.contains(' ')) {
        addCallsignRecord(field, callsigns);
        Message msg = parseMessage(field);
        if (msg.toMarker(callsignDict: callsigns) != null) {
          holder.addMarker(msg.toMarker(callsignDict: callsigns)!);
        }
      }
    }
  }

  void clearSocket() {
    if (holder.mapState.socket != null) {
      holder.mapState.socket!.close();
      holder.setSocket(null);
    }
  }
}
