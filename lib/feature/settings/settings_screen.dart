import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grid_tracker/app/di.dart';
import 'package:grid_tracker/feature/settings/settings_holder.dart';
import 'package:grid_tracker/feature/settings/settings_state.dart';
import 'package:riverpod/riverpod.dart';

final provider = StateNotifierProvider<SettingsStateHolder, SettingsState>(
    (ref) => di.settingsHolder);

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    final manager = di.settingsManager;

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: manager.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: manager.ipC,
                  decoration: const InputDecoration(
                    label: Text('IP address'),
                  ),
                  onChanged: manager.setIp,
                ),
                TextFormField(
                  controller: manager.portC,
                  decoration: const InputDecoration(
                    label: Text('Port'),
                  ),
                  onChanged: manager.setPort,
                ),
                ElevatedButton(
                  onPressed: () {
                    manager.setAddress();
                    Navigator.pop(context);
                  },
                  child: Text(manager.isConnected ? 'Disconnect' : 'Connect'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
