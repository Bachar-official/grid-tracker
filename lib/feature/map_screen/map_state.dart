import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

@immutable
class MapState {
  final RawDatagramSocket? socket;
  final List<Marker> markers;
  bool get isConnected => socket != null;

  const MapState({this.socket, required this.markers});

  const MapState.initial()
      : socket = null,
        markers = const [];

  MapState copyWith(
          {RawDatagramSocket? socket,
          bool nullSocket = false,
          List<Marker>? markers}) =>
      MapState(
          socket: nullSocket ? null : socket ?? this.socket,
          markers: markers ?? this.markers);
}
