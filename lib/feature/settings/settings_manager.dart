import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grid_tracker/feature/home/home_manager.dart';
import 'package:grid_tracker/feature/map_screen/map_manager.dart';
import 'package:grid_tracker/feature/settings/settings_holder.dart';
import 'package:grid_tracker/utils/utils.dart';
import 'package:logger/logger.dart';

class SettingsManager {
  final Logger logger;
  final SettingsStateHolder holder;
  final GlobalKey<ScaffoldMessengerState> key;
  final MapManager mapManager;
  final HomeManager homeManager;
  final TextEditingController ipC = TextEditingController();
  final TextEditingController portC = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SettingsManager(
      {required this.holder,
      required this.logger,
      required this.key,
      required this.homeManager,
      required this.mapManager}) {
    ipC.value = TextEditingValue(text: holder.settingsState.ip);
    portC.value = TextEditingValue(text: holder.settingsState.port.toString());
  }

  bool get isConnected => mapManager.holder.mapState.isConnected;

  void setIp(String ip) {
    holder.setIp(ip);
  }

  void setPort(String port) {
    if (int.tryParse(port) != null) {
      holder.setPort(int.parse(port));
    }
  }

  Future<void> setAddress() async {
    if (formKey.currentState!.validate()) {
      if (mapManager.holder.mapState.socket == null) {
        logger.d('Try to connect to server');
        try {
          RawDatagramSocket socket = await RawDatagramSocket.bind(
              InternetAddress(holder.settingsState.ip),
              holder.settingsState.port);
          mapManager.setSocket(socket);
        } catch (e) {
          logger.e(e);
          showSnackBar(key, Colors.red, 'Error while connecting to UDP');
        }
      } else {
        logger.d('Disconnecting from server');
        mapManager.clearSocket();
      }
    }
    // Go to Map screen
    homeManager.setPage(0);
  }
}
