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
}
