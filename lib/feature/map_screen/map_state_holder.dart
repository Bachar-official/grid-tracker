import 'dart:io';

import 'package:grid_tracker/feature/map_screen/map_state.dart';
import 'package:riverpod/riverpod.dart';

class MapStateHolder extends StateNotifier<MapState> {
  MapStateHolder() : super(const MapState.initial());

  MapState get mapState => state;

  void setSocket(RawDatagramSocket? socket) {
    if (socket == null) {
      state = state.copyWith(nullSocket: true, socket: null);
    } else {
      state = state.copyWith(socket: socket);
    }
  }
}
