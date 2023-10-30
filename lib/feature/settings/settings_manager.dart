import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:grid_tracker/data/repository/settings_repository.dart';
import 'package:grid_tracker/feature/home/home_manager.dart';
import 'package:grid_tracker/feature/map_screen/map_manager.dart';
import 'package:grid_tracker/feature/settings/settings_holder.dart';
import 'package:grid_tracker/utils/utils.dart';
import 'package:logger/logger.dart';

class SettingsManager {
  final Logger logger;
  final SettingsStateHolder holder;
  final SettingsRepository settingsRepository;
  final GlobalKey<NavigatorState> key;
  final MapManager mapManager;
  final HomeManager homeManager;
  final TextEditingController ipC = TextEditingController();
  final TextEditingController portC = TextEditingController();
  final TextEditingController callsignC = TextEditingController();
  final TextEditingController qthC = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SettingsManager(
      {required this.holder,
      required this.logger,
      required this.settingsRepository,
      required this.key,
      required this.homeManager,
      required this.mapManager}) {
    setCallsign(settingsRepository.callsign);
    setIp(settingsRepository.ip);
    setPort(settingsRepository.port.toString());
    setQth(settingsRepository.port.toString());
    setMode(settingsRepository.isDarkTheme);
    ipC.value = TextEditingValue(text: settingsRepository.ip);
    portC.value = TextEditingValue(text: settingsRepository.port.toString());
    callsignC.value = TextEditingValue(text: settingsRepository.callsign);
    qthC.value = TextEditingValue(text: settingsRepository.qth);
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

  void setCallsign(String callsign) {
    if (isCallSign(callsign)) {
      holder.setCallsign(callsign);
    }
  }

  void setMode(bool isDarkMode) {
    holder.setMode(isDarkMode);
  }

  void setQth(String qth) {
    if (isQTH(qth)) {
      holder.setQth(qth);
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
          socket.broadcastEnabled = true;
          mapManager.setSocket(socket);
          logger.i('Connected');
          showInfoBar(
              key: key,
              severity: InfoBarSeverity.success,
              title: 'Connected',
              message: 'Connected to UDP server ${holder.settingsState.ip}');
        } catch (e) {
          logger.e(e);
          showInfoBar(
              key: key,
              severity: InfoBarSeverity.error,
              title: 'Error',
              message: e.toString());
        }
      } else {
        logger.d('Disconnecting from server');
        mapManager.clearSocket();
        logger.i('Disconnected');
      }
      // Go to Map screen
      homeManager.setPage(0);
    }
  }

  void saveSettings() {
    if (formKey.currentState!.validate()) {
      try {
        settingsRepository
          ..setCallsign(holder.settingsState.callsign)
          ..setIp(holder.settingsState.ip)
          ..setPort(holder.settingsState.port)
          ..setDarkTheme(holder.settingsState.isDarkTheme)
          ..setQth(holder.settingsState.qth);
        showInfoBar(
            key: key,
            severity: InfoBarSeverity.success,
            title: 'Success',
            message: 'Settings saved successfully');
      } catch (e) {
        showInfoBar(
            key: key,
            severity: InfoBarSeverity.error,
            title: 'Error',
            message: e.toString());
      }
    }
  }
}
