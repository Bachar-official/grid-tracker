import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:grid_tracker/data/entity/message.dart';
import 'package:grid_tracker/feature/map_screen/map_state.dart';
import 'package:riverpod/riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class MapStateHolder extends StateNotifier<MapState> {
  MapStateHolder() : super(const MapState.initial());

  MapState get mapState => state;

  void setSocket(RawDatagramSocket? socket) {
    if (socket == null) {
      state = state.copyWith(nullSocket: true, socket: null);
    } else {
      state = state.copyWith(socket: socket);
    }
  }

  void setDarkMode(bool isDarkMode) {
    state = state.copyWith(isDarkMode: isDarkMode);
  }

  void setMarkers(List<Marker> markers) {
    state = state.copyWith(markers: markers);
  }

  void clearMarkers() {
    state = state.copyWith(markers: []);
  }

  void setMessages(List<Marker> messages) {
    state = state.copyWith(messages: messages);
  }

  void clearMessages() {
    state = state.copyWith(messages: []);
  }

  void setMyQth(String myQth) {
    state = state.copyWith(myQth: myQth);
  }

  void addMarker(Marker marker) {
    List<Marker> markers = state.markers;
    final index = markers.indexWhere((element) =>
        element.point.latitude == marker.point.latitude &&
        element.point.longitude == marker.point.longitude);
    if (index != -1) {
      markers.removeAt(index);
      markers.add(marker);
      state = state.copyWith(markers: markers);
    } else {
      List<Marker> newMarkers = [...state.markers, marker];
      state = state.copyWith(markers: newMarkers);
    }
  }

  void addMessage(Marker message) {
    List<Marker> messages = state.messages;
    final index = messages.indexWhere((element) => element.key == message.key);
    if (index != -1) {
      messages.removeAt(index);
      messages.add(message);
      state = state.copyWith(messages: messages);
    } else {
      List<Marker> newMarkers = [...state.markers, message];
      state = state.copyWith(markers: newMarkers);
    }
  }

  void removeMessage(Key key) {
    List<Marker> messages = state.messages;
    final index = messages.indexWhere((element) => element.key == key);
    if (index != -1) {
      messages.removeAt(index);
      state = state.copyWith(messages: messages);
    }
  }

  void setMapCache(CacheStore? mapCache) {
    if (mapCache == null) {
      state = state.copyWith(nullCache: true, mapCache: null);
    } else {
      state = state.copyWith(mapCache: mapCache);
    }
  }

  void addMessageToFeed(FeedMessage message) {
    final newFeed = [...state.feed, message];
    state = state.copyWith(feed: newFeed);
  }

  void clearFeed() {
    state = state.copyWith(feed: []);
  }

  void toggleFeed(bool isExpanded) {
    state = state.copyWith(isFeedExpanded: isExpanded);
  }
}
