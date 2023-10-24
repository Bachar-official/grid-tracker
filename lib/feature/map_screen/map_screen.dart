import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grid_tracker/app/di.dart';
import 'package:grid_tracker/feature/map_screen/map_state.dart';
import 'package:grid_tracker/feature/map_screen/map_state_holder.dart';
import 'package:grid_tracker/feature/settings/settings_screen.dart';
import 'package:latlong2/latlong.dart';

final provider =
    StateNotifierProvider<MapStateHolder, MapState>((ref) => di.mapHolder);

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    final manager = di.mapManager;

    return Scaffold(
      drawer: const SettingsScreen(),
      appBar: AppBar(
        title: Badge(
          backgroundColor: state.isConnected ? Colors.green : Colors.red,
          label: Text(state.isConnected ? 'Connected' : 'Disconnected'),
          child: const Text('Map'),
        ),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(0, 0),
          initialZoom: 2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(markers: state.markers),
        ],
      ),
    );
  }
}
