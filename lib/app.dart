import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_brand.dart';
import 'screens/splash/splash_screen.dart';
import 'theme/app_theme.dart';

class BarberApp extends StatelessWidget {
  const BarberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppBrand.appName,
      theme: AppTheme.darkTheme(),
      home: const SplashScreen(),
      locale: const Locale('pt', 'BR'),

      supportedLocales: const [
        Locale('pt', 'BR'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}