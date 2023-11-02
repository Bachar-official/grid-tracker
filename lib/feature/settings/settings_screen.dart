import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grid_tracker/app/di.dart';
import 'package:grid_tracker/feature/settings/settings_holder.dart';
import 'package:grid_tracker/feature/settings/settings_state.dart';
import 'package:grid_tracker/utils/validators.dart';

final provider = StateNotifierProvider<SettingsStateHolder, SettingsState>(
    (ref) => di.settingsHolder);

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    final manager = di.settingsManager;

    Typography typography = FluentTheme.of(context).typography;

    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Settings'),
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: manager.formKey,
              child: Column(
                children: [
                  Text(
                    'User settings',
                    style: typography.subtitle,
                  ),
                  InfoLabel(
                    label: 'Callsign',
                    child: TextFormBox(
                      placeholder: 'Callsign',
                      controller: manager.callsignC,
                      onChanged: manager.setCallsign,
                      validator: validateCallsign,
                    ),
                  ),
                  InfoLabel(
                    label: 'QTH locator',
                    child: TextFormBox(
                      placeholder: 'QTH locator',
                      controller: manager.qthC,
                      onChanged: manager.setQth,
                      validator: validateQth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ToggleSwitch(
                        content: Text(state.inKilometers
                            ? 'Distance in kilometers'
                            : 'Distance in miles'),
                        checked: state.inKilometers,
                        onChanged: manager.setDistanceMeasure),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ToggleSwitch(
                        content: const Text('Dark mode'),
                        checked: state.isDarkTheme,
                        onChanged: manager.setMode),
                  ),
                  const Divider(),
                  Text(
                    'Net settings',
                    style: typography.subtitle,
                  ),
                  InfoLabel(
                    label: 'IP address',
                    child: TextFormBox(
                      readOnly: manager.isConnected,
                      placeholder: 'IP address',
                      controller: manager.ipC,
                      onChanged: manager.setIp,
                      validator: validateIp,
                    ),
                  ),
                  InfoLabel(
                    label: 'Port',
                    child: TextFormBox(
                      readOnly: manager.isConnected,
                      placeholder: 'Port',
                      controller: manager.portC,
                      onChanged: manager.setPort,
                      validator: validatePort,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilledButton(
                          onPressed: manager.setAddress,
                          child: Text(
                              manager.isConnected ? 'Disconnect' : 'Connect'),
                        ),
                        FilledButton(
                          onPressed: manager.saveSettings,
                          child: const Text('Save settings'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
