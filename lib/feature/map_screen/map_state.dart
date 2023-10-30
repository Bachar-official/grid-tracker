import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

@immutable
class MapState {
  final RawDatagramSocket? socket;
  final List<Marker> markers;
  final List<Marker> messages;
  final CacheStore? mapCache;
  bool get isConnected => socket != null;

  const MapState(
      {this.socket,
      required this.markers,
      required this.messages,
      this.mapCache});

  const MapState.initial()
      : socket = null,
        markers = const [],
        mapCache = null,
        messages = const [];

  MapState copyWith(
          {RawDatagramSocket? socket,
          bool nullSocket = false,
          bool nullCache = false,
          CacheStore? mapCache,
          List<Marker>? markers,
          List<Marker>? messages}) =>
      MapState(
          socket: nullSocket ? null : socket ?? this.socket,
          markers: markers ?? this.markers,
          messages: messages ?? this.messages,
          mapCache: nullCache ? null : mapCache ?? this.mapCache);
}
