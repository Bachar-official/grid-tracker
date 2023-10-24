import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class MapState {
  final RawDatagramSocket? socket;
  bool get isConnected => socket != null;

  const MapState({this.socket});

  const MapState.initial() : socket = null;

  MapState copyWith({RawDatagramSocket? socket, bool nullSocket = false}) =>
      MapState(
        socket: nullSocket ? null : socket ?? this.socket,
      );
}
