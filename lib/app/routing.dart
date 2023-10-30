import 'package:flutter/material.dart';
import 'package:grid_tracker/feature/home/home_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return _buildRoute((context) => const HomeScreen(), settings);
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }

  static const homePage = '/';
}

MaterialPageRoute _buildRoute(WidgetBuilder builder, RouteSettings settings) =>
    MaterialPageRoute(builder: builder, settings: settings);
