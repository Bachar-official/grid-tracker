import 'dart:io';

import 'package:grid_tracker/feature/map_screen/map_state.dart';
import 'package:riverpod/riverpod.dart';

class MapStateHolder extends StateNotifier<MapState> {
  MapStateHolder() : super(const MapState.initial());

  MapState get mapState => state;

  void setAddress(InternetAddress? address) {
    if (address == null) {
      state = state.copyWith(nullAddress: true, address: null);
    } else {
      state = state.copyWith(address: address);
    }
  }

  void setSocket(RawDatagramSocket? socket) {
    if (socket == null) {
      state = state.copyWith(nullSocket: true, socket: null);
    } else {
      state = state.copyWith(socket: socket);
    }
  }

  void setIp(String ip) {
    state = state.copyWith(ip: ip);
  }

  void setPort(int port) {
    state = state.copyWith(port: port);
  }
}
