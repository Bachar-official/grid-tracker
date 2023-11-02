import 'package:fluent_ui/fluent_ui.dart';
import 'package:grid_tracker/data/entity/qso.dart';

@immutable
class HistoryState {
  final List<QSO> qsos;

  const HistoryState({required this.qsos});

  HistoryState.initial() : qsos = [];

  HistoryState copyWith({List<QSO>? qsos}) =>
      HistoryState(qsos: qsos ?? this.qsos);
}
