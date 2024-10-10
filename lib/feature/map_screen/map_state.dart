import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:grid_tracker/data/entity/message.dart';

@immutable
class MapState {
  final RawDatagramSocket? socket;
  final List<Marker> markers;
  final List<Marker> messages;
  final List<FeedMessage> feed;
  final bool isFeedExpanded;
  final CacheStore? mapCache;
  final bool isDarkMode;
  final String myQth;
  bool get isConnected => socket != null;

  const MapState(
      {this.socket,
      required this.isFeedExpanded,
      required this.feed,
      required this.myQth,
      required this.isDarkMode,
      required this.markers,
      required this.messages,
      this.mapCache});

  const MapState.initial()
      : socket = null,
        feed = const [],
        markers = const [],
        mapCache = null,
        myQth = '',
        isDarkMode = false,
        isFeedExpanded = false,
        messages = const [];

  MapState copyWith(
          {RawDatagramSocket? socket,
          bool nullSocket = false,
          bool nullCache = false,
          CacheStore? mapCache,
          List<Marker>? markers,
          List<FeedMessage>? feed,
          String? myQth,
          bool? isDarkMode,
          bool? isFeedExpanded,
          List<Marker>? messages}) =>
      MapState(
          isDarkMode: isDarkMode ?? this.isDarkMode,
          feed: feed ?? this.feed,
          myQth: myQth ?? this.myQth,
          socket: nullSocket ? null : socket ?? this.socket,
          markers: markers ?? this.markers,
          isFeedExpanded: isFeedExpanded ?? this.isFeedExpanded,
          messages: messages ?? this.messages,
          mapCache: nullCache ? null : mapCache ?? this.mapCache);
}
