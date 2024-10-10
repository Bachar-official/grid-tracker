import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grid_tracker/data/entity/message.dart';
import 'package:grid_tracker/data/entity/qso.dart';
import 'package:grid_tracker/feature/history/history_manager.dart';
import 'package:grid_tracker/feature/map_screen/map_state_holder.dart';
import 'package:grid_tracker/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class MapManager {
  final Logger logger;
  final MapStateHolder holder;
  final HistoryManager historyManager;
  final GlobalKey<NavigatorState> key;
  MapManager(
      {required this.holder,
      required this.key,
      required this.logger,
      required this.historyManager});
  final UniqueKey mapKey = UniqueKey();
  Map<String, String> callsigns = {};
  final ScrollController scrollController = ScrollController();

  Future<void> setSocket(RawDatagramSocket socket) async {
    holder.setSocket(socket);
    if (holder.mapState.socket != null) {
      // socket.listen((_) {
      //   var datagram = socket.receive();
      //   if (datagram != null) {
      //     parseData(datagram.data);
      //   }
      // });
      await for (var _ in socket) {
        var datagram = socket.receive();
        if (datagram != null) {
          parseData(datagram.data);
        }
      }
    }
  }

  void setMyQth(String myQth) => holder.setMyQth(myQth);

  void setIsDarkMode(bool isDarkMode) {
    holder.setDarkMode(isDarkMode);
  }

  Future<void> setCache() async {
    try {
      final dir = await getTemporaryDirectory();
      holder.setMapCache(
          FileCacheStore('${dir.path}${Platform.pathSeparator}MapTiles'));
    } catch (e) {
      logger.e(e.toString());
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
        QSO? qso = getMessageQso(field, callsigns);
        addCallsignRecord(field, callsigns);
        Message msg = parseMessage(field);
        addMessageToFeed(msg);
        if (qso != null) {
          historyManager.addQso(qso);
        }
        if (msg.toMarker(callsignDict: callsigns) != null) {
          holder.addMarker(msg.toMarker(callsignDict: callsigns)!);
        }
      }
    }
  }

  void addMessageToFeed(Message message) {
    holder.addMessageToFeed(FeedMessage.fromMessage(message));
    if (holder.mapState.isFeedExpanded && scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent, // Прокрутить до конца
        duration: const Duration(milliseconds: 300), // Длительность анимации
        curve: Curves.easeOut, // Кривая анимации
      );
    }
  }

  void clearSocket() {
    if (holder.mapState.socket != null) {
      holder.mapState.socket!.close();
      holder.setSocket(null);
    }
  }

  void toggleFeed() {
    holder.toggleFeed(!holder.mapState.isFeedExpanded);
  }
}
