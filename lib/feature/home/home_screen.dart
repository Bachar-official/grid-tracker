import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grid_tracker/app/di.dart';
import 'package:grid_tracker/feature/history/history_screen.dart';
import 'package:grid_tracker/feature/home/home_state.dart';
import 'package:grid_tracker/feature/home/home_state_holder.dart';
import 'package:grid_tracker/feature/map_screen/map_screen.dart';
import 'package:grid_tracker/feature/settings/settings_screen.dart';
import 'package:window_manager/window_manager.dart';

final provider =
    StateNotifierProvider<HomeStateHolder, HomeState>((ref) => di.homeHolder);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    final manager = di.homeManager;
    return NavigationView(
      appBar: const NavigationAppBar(
        automaticallyImplyLeading: false,
        title: DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text('Yet Another Grid Tracker'),
          ),
        ),
        actions: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
            ),
            WindowButtons(),
          ],
        ),
      ),
      pane: NavigationPane(
        selected: state.page,
        onChanged: manager.setPage,
        displayMode: PaneDisplayMode.auto,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.map_pin),
            body: const MapScreen(),
            title: const Text('Map'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.history),
            body: const HistoryScreen(),
            title: const Text('History'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            body: const SettingsScreen(),
            title: const Text('Settings'),
          ),
        ],
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
