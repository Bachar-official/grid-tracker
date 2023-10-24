import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class MapState {
  final RawDatagramSocket? socket;
  final InternetAddress? address;
  final String ip;
  final int port;

  const MapState(
      {this.address, this.socket, required this.ip, required this.port});

  const MapState.initial()
      : socket = null,
        address = null,
        ip = '127.0.0.1',
        port = 2237;

  MapState copyWith(
          {RawDatagramSocket? socket,
          InternetAddress? address,
          String? ip,
          int? port,
          bool nullSocket = false,
          bool nullAddress = false}) =>
      MapState(
        ip: ip ?? this.ip,
        port: port ?? this.port,
        socket: nullSocket ? null : socket ?? this.socket,
        address: nullAddress ? null : address ?? this.address,
      );
}
