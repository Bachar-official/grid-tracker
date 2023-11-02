import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grid_tracker/data/entity/qso.dart';
import 'package:grid_tracker/feature/history/history_state.dart';

class HistoryStateHolder extends StateNotifier<HistoryState> {
  HistoryStateHolder() : super(HistoryState.initial());

  HistoryState get historyState => state;

  void setQsos(List<QSO> qsos) {
    state = state.copyWith(qsos: qsos);
  }
}
