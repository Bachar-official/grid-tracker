import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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

  void setMarkers(List<Marker> markers) {
    state = state.copyWith(markers: markers);
  }

  void clearMarkers() {
    state = state.copyWith(markers: []);
  }

  void addMarker(Marker marker) {
    List<Marker> markers = state.markers;
    final index = markers.indexWhere((element) => element.key == marker.key);
    if (index != -1) {
      markers.removeAt(index);
      markers.add(marker);
      state = state.copyWith(markers: markers);
    } else {
      List<Marker> newMarkers = [...state.markers, marker];
      state = state.copyWith(markers: newMarkers);
    }
  }

  void removeMarker(Key key) {
    List<Marker> markers = state.markers;
    final index = markers.indexWhere((element) => element.key == key);
    if (index != -1) {
      markers.removeAt(index);
      state = state.copyWith(markers: markers);
    }
  }
}
