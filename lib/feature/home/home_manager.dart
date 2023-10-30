import 'package:flutter/material.dart';
import 'package:grid_tracker/feature/home/home_state_holder.dart';
import 'package:logger/logger.dart';

class HomeManager {
  final HomeStateHolder holder;
  final Logger logger;
  final GlobalKey<NavigatorState> key;

  HomeManager({required this.holder, required this.key, required this.logger});

  void setPage(int page) => holder.setPage(page);
}
