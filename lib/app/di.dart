import 'package:flutter/material.dart';
import 'package:grid_tracker/data/repository/settings_repository.dart';
import 'package:grid_tracker/feature/history/history_manager.dart';
import 'package:grid_tracker/feature/history/history_state_holder.dart';
import 'package:grid_tracker/feature/home/home_manager.dart';
import 'package:grid_tracker/feature/home/home_state_holder.dart';
import 'package:grid_tracker/feature/map_screen/map_manager.dart';
import 'package:grid_tracker/feature/map_screen/map_state_holder.dart';
import 'package:grid_tracker/feature/settings/settings_holder.dart';
import 'package:grid_tracker/feature/settings/settings_manager.dart';
import 'package:logger/logger.dart';

class DI {
  late final GlobalKey<NavigatorState> key;
  late final Logger logger;
  late final SettingsRepository settingsRepository;

  late final HomeManager homeManager;
  late final HomeStateHolder homeHolder;

  late final MapStateHolder mapHolder;
  late final MapManager mapManager;

  late final SettingsStateHolder settingsHolder;
  late final SettingsManager settingsManager;

  late final HistoryStateHolder historyHolder;
  late final HistoryManager historyManager;

  DI() {
    key = GlobalKey<NavigatorState>();
    logger = Logger();
    settingsRepository = SettingsRepository();
    homeHolder = HomeStateHolder();
    homeManager = HomeManager(holder: homeHolder, key: key, logger: logger);
    historyHolder = HistoryStateHolder();
    historyManager = HistoryManager(
        holder: historyHolder, settingsRepository: settingsRepository);
    mapHolder = MapStateHolder();
    mapManager = MapManager(
        holder: mapHolder,
        logger: logger,
        historyManager: historyManager,
        key: key);
    settingsHolder = SettingsStateHolder();
    settingsManager = SettingsManager(
        settingsRepository: settingsRepository,
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
