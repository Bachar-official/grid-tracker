import 'dart:io';

import 'package:grid_tracker/feature/map_screen/map_state_holder.dart';
import 'package:logger/logger.dart';

class MapManager {
  final Logger logger;
  final MapStateHolder holder;
  MapManager({required this.holder, required this.logger});

  Future<void> setSocket(RawDatagramSocket socket) async {
    holder.setSocket(socket);
    if (holder.mapState.socket != null) {
      await for (var msg in holder.mapState.socket!) {
        var datagram = socket.receive();
        if (datagram != null) {
          logger.d(datagram.data);
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
