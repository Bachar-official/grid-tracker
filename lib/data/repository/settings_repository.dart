import 'package:hive/hive.dart';

class SettingsRepository {
  late final Box _settingsBox;

  final _ip = 'ip';
  final _port = 'port';
  final _callsign = 'callsign';
  final _qth = 'qth';
  final _darkTheme = 'darkTheme';
  final _kilometers = 'km';

  SettingsRepository() {
    _settingsBox = Hive.box('grid-settings');
  }

  String get ip => _getIp();
  int get port => _getPort();
  String get callsign => _getCallsign();
  String get qth => _getQth();
  bool get isDarkTheme => _getIsDarkTheme();
  bool get isKilometers => _getIsKilometers();

  String _getIp() {
    return _settingsBox.get(_ip, defaultValue: '127.0.0.1');
  }

  int _getPort() {
    return _settingsBox.get(_port, defaultValue: 2237);
  }

  String _getCallsign() {
    return _settingsBox.get(_callsign, defaultValue: '');
  }

  String _getQth() {
    return _settingsBox.get(_qth, defaultValue: '');
  }

  bool _getIsDarkTheme() {
    return _settingsBox.get(_darkTheme, defaultValue: false);
  }

  bool _getIsKilometers() {
    return _settingsBox.get(_kilometers, defaultValue: true);
  }

  void setIp(String ip) {
    _settingsBox.put(_ip, ip);
  }

  void setPort(int port) {
    _settingsBox.put(_port, port);
  }

  void setCallsign(String callsign) {
    _settingsBox.put(_callsign, callsign);
  }

  void setQth(String qth) {
    _settingsBox.put(_qth, qth);
  }

  void setDarkTheme(bool isDarkTheme) {
    _settingsBox.put(_darkTheme, isDarkTheme);
  }

  void setKilometers(bool isKilometers) {
    _settingsBox.put(_kilometers, isKilometers);
  }
}
