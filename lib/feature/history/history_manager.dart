import 'package:grid_tracker/data/entity/qso.dart';
import 'package:grid_tracker/data/repository/settings_repository.dart';
import 'package:grid_tracker/feature/history/history_state_holder.dart';

class HistoryManager {
  final HistoryStateHolder holder;
  final SettingsRepository settingsRepository;

  String get myQth => settingsRepository.qth;
  String get distanceMeasure => settingsRepository.isKilometers ? 'km' : 'mil';

  const HistoryManager(
      {required this.holder, required this.settingsRepository});

  void setQsos(List<QSO> qsos) => holder.setQsos(qsos);

  void addQso(QSO qso) => holder.setQsos([...holder.historyState.qsos, qso]);

  void clearQsos() => holder.setQsos([]);
}
