import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grid_tracker/app/di.dart';
import 'package:grid_tracker/data/constants/constants.dart';
import 'package:grid_tracker/feature/map_screen/components/connect_state_circle.dart';
import 'package:grid_tracker/feature/map_screen/components/feed_message_item.dart';
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
    final manager = di.mapManager;

    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Map'),
        commandBar: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConnectStateCircle(
              isConnected: state.isConnected,
            ),
            IconButton(
              icon: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const Icon(Icons.message, size: 30),
                  Icon(
                      state.isFeedExpanded
                          ? FluentIcons.chevron_right
                          : FluentIcons.chevron_left,
                      size: 10,
                      color: Colors.green)
                ],
              ),
              onPressed: manager.toggleFeed,
            ),
          ],
        ),
      ),
      content: Row(
        children: [
          Flexible(
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(0, 30.51),
                initialZoom: 2,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  tileBuilder: state.isDarkMode
                      ? (context, child, image) => ColorFiltered(
                            colorFilter: const ColorFilter.matrix(invertMatrix),
                            child: child,
                          )
                      : null,
                  tileProvider: state.mapCache == null
                      ? null
                      : CachedTileProvider(store: state.mapCache!),
                ),
                MarkerLayer(markers: state.markers),
                MarkerLayer(markers: state.messages),
              ],
            ),
          ),
          Visibility(
            visible: state.isFeedExpanded,
            child: SizedBox(
              width: 200,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: [
                    const Text('Feed'),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        controller: manager.scrollController,
                        itemCount: state.feed.length,
                        itemBuilder: (context, index) => FeedMessageItem(
                            key: UniqueKey(), message: state.feed[index]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
