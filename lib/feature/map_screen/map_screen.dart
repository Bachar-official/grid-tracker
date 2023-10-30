import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grid_tracker/app/di.dart';
import 'package:grid_tracker/feature/map_screen/components/connect_state_circle.dart';
import 'package:grid_tracker/feature/map_screen/map_state.dart';
import 'package:grid_tracker/feature/map_screen/map_state_holder.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

final provider =
    StateNotifierProvider<MapStateHolder, MapState>((ref) => di.mapHolder);

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Map'),
        commandBar: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConnectStateCircle(
              isConnected: state.isConnected,
            )
          ],
        ),
      ),
      content: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(0, 30.51),
          initialZoom: 2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            tileProvider: state.mapCache == null
                ? null
                : CachedTileProvider(store: state.mapCache!),
          ),
          MarkerLayer(markers: state.markers),
          MarkerLayer(markers: state.messages),
        ],
      ),
    );
  }
}
