import 'package:flutter/material.dart';
import 'package:grid_tracker/app/di.dart';
import 'package:grid_tracker/feature/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: di.key,
      home: const HomeScreen(),
    );
  }
}
