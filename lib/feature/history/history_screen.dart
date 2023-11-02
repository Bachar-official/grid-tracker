import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grid_tracker/app/di.dart';
import 'package:grid_tracker/feature/history/history_state.dart';
import 'package:grid_tracker/feature/history/history_state_holder.dart';

final provider = StateNotifierProvider<HistoryStateHolder, HistoryState>(
    (ref) => di.historyHolder);

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    final manager = di.historyManager;

    return ScaffoldPage(
      header: const PageHeader(
        title: Text('History'),
      ),
      content: SingleChildScrollView(
        child: Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                const Center(
                  child: Text('Callsign'),
                ),
                const Center(
                  child: Text('QTH'),
                ),
                Center(
                  child: Text('Distance (${manager.distanceMeasure})'),
                ),
                const Center(
                  child: Text('Seen at'),
                ),
              ],
            ),
            ...state.qsos
                .map((qso) => qso.toTableRow(myQth: manager.myQth))
                .toList(),
          ],
        ),
      ),
    );
  }
}
