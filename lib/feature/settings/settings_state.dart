import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class SettingsState {
  final String ip;
  final int port;
  final String callsign;
  final String qth;
  final ThemeMode themeMode;
  final bool inKilometers;

  bool get isDarkTheme => themeMode == ThemeMode.dark;

  const SettingsState(
      {required this.ip,
      required this.inKilometers,
      required this.port,
      required this.callsign,
      required this.qth,
      required this.themeMode});

  const SettingsState.initial()
      : ip = '127.0.0.1',
        inKilometers = true,
        port = 2237,
        callsign = '',
        themeMode = ThemeMode.light,
        qth = '';

  SettingsState copyWith(
          {InternetAddress? address,
          int? port,
          String? ip,
          String? callsign,
          bool? inKilometers,
          String? qth,
          ThemeMode? themeMode}) =>
      SettingsState(
          ip: ip ?? this.ip,
          inKilometers: inKilometers ?? this.inKilometers,
          port: port ?? this.port,
          callsign: callsign ?? this.callsign,
          qth: qth ?? this.qth,
          themeMode: themeMode ?? this.themeMode);
}
