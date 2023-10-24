import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class SettingsState {
  final String ip;
  final int port;

  const SettingsState({required this.ip, required this.port});

  const SettingsState.initial()
      : ip = '127.0.0.1',
        port = 2237;

  SettingsState copyWith(
          {InternetAddress? address,
          int? port,
          String? ip,
          bool nullAddress = false}) =>
      SettingsState(
        ip: ip ?? this.ip,
        port: port ?? this.port,
      );
}
