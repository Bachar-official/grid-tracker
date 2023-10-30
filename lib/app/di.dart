import 'package:flutter/material.dart';
import 'package:grid_tracker/feature/home/home_manager.dart';
import 'package:grid_tracker/feature/home/home_state_holder.dart';
import 'package:grid_tracker/feature/map_screen/map_manager.dart';
import 'package:grid_tracker/feature/map_screen/map_state_holder.dart';
import 'package:grid_tracker/feature/settings/settings_holder.dart';
import 'package:grid_tracker/feature/settings/settings_manager.dart';
import 'package:logger/logger.dart';

class DI {
  late final GlobalKey<ScaffoldMessengerState> key;
  late final Logger logger;

  late final HomeManager homeManager;
  late final HomeStateHolder homeHolder;

  late final MapStateHolder mapHolder;
  late final MapManager mapManager;

  late final SettingsStateHolder settingsHolder;
  late final SettingsManager settingsManager;

  DI() {
    key = GlobalKey<ScaffoldMessengerState>();
    logger = Logger();
    homeHolder = HomeStateHolder();
    homeManager = HomeManager(holder: homeHolder, key: key, logger: logger);
    mapHolder = MapStateHolder();
    mapManager = MapManager(holder: mapHolder, logger: logger);
    settingsHolder = SettingsStateHolder();
    settingsManager = SettingsManager(
        homeManager: homeManager,
        holder: settingsHolder,
        logger: logger,
        key: key,
        mapManager: mapManager);
  }

  Future<void> init() async {
    await mapManager.setCache();
    logger.d('DI initialized');
  }
}

final di = DI();
