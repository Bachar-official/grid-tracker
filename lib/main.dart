import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grid_tracker/app/app.dart';
import 'package:grid_tracker/app/di.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('grid-settings');
  di.init();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
