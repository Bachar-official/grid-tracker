import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grid_tracker/app/di.dart';
import 'package:grid_tracker/feature/history/history_screen.dart';
import 'package:grid_tracker/feature/home/home_state.dart';
import 'package:grid_tracker/feature/home/home_state_holder.dart';
import 'package:grid_tracker/feature/map_screen/map_screen.dart';
import 'package:grid_tracker/feature/settings/settings_screen.dart';

final provider =
    StateNotifierProvider<HomeStateHolder, HomeState>((ref) => di.homeHolder);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    final manager = di.homeManager;
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: state.page,
        onDestinationSelected: manager.setPage,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: const [MapScreen(), HistoryScreen(), SettingsScreen()][state.page],
    );
  }
}
