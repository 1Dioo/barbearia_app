import 'package:flutter/material.dart';
import 'core/app_brand.dart';
import 'screens/entry_gate.dart';
import 'theme/app_theme.dart';

class BarberApp extends StatelessWidget {
  const BarberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppBrand.appName,
      theme: AppTheme.darkTheme(),
      home: const EntryGate(),
    );
  }
}