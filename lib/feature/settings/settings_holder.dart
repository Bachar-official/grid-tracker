import 'package:fluent_ui/fluent_ui.dart';
import 'package:grid_tracker/feature/settings/settings_state.dart';
import 'package:riverpod/riverpod.dart';

class SettingsStateHolder extends StateNotifier<SettingsState> {
  SettingsStateHolder() : super(const SettingsState.initial());

  SettingsState get settingsState => state;

  void setIp(String ip) {
    state = state.copyWith(ip: ip);
  }

  void setPort(int port) {
    state = state.copyWith(port: port);
  }

  void setCallsign(String callsign) {
    state = state.copyWith(callsign: callsign);
  }

  void setQth(String qth) {
    state = state.copyWith(qth: qth);
  }

  void setMode(bool isDarkTheme) {
    state = state.copyWith(
        themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light);
  }
}
