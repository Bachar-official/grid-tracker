import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grid_tracker/app/di.dart';
import 'package:grid_tracker/app/routing.dart';
import 'package:grid_tracker/feature/settings/settings_holder.dart';
import 'package:grid_tracker/feature/settings/settings_state.dart';

final provider = StateNotifierProvider<SettingsStateHolder, SettingsState>(
    (ref) => di.settingsHolder);

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    return FluentApp(
      themeMode: state.themeMode,
      navigatorKey: di.key,
      onGenerateRoute: AppRouter.generateRoute,
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blue,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      theme: FluentThemeData(
        accentColor: Colors.blue,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
    );
  }
}
