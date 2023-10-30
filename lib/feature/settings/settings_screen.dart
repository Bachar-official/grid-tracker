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
    // final state = ref.watch(provider);
    final manager = di.settingsManager;

    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Settings'),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: manager.formKey,
            child: Column(
              children: [
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
                  child: FilledButton(
                    onPressed: manager.setAddress,
                    child: Text(manager.isConnected ? 'Disconnect' : 'Connect'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
