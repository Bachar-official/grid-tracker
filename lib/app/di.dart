import 'package:flutter/material.dart';
import 'package:grid_tracker/feature/home/home_manager.dart';
import 'package:grid_tracker/feature/home/home_state_holder.dart';
import 'package:logger/logger.dart';

class DI {
  late final GlobalKey<ScaffoldMessengerState> key;
  late final HomeManager homeManager;
  late final HomeStateHolder homeHolder;
  late final Logger logger;

  DI() {
    key = GlobalKey<ScaffoldMessengerState>();
    logger = Logger();
    homeHolder = HomeStateHolder();
    homeManager = HomeManager(holder: homeHolder, key: key, logger: logger);
  }

  void init() {
    logger.d('DI initialized');
  }
}

final di = DI();
