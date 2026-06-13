/*
 * Classe responsável pela configuração visual global do aplicativo.
 *
 * Define cores, tipografia, componentes personalizados e tema
 * principal utilizado em toda a interface da Royal Barber,
 * garantindo padronização visual e melhor experiência do usuário.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*
 * Classe responsável pela configuração visual global do aplicativo.
 *
 * Define cores, tipografia, componentes personalizados e tema
 * principal utilizado em toda a interface da Royal Barber,
 * garantindo padronização visual e melhor experiência do usuário.
 */
class AppTheme {
  static const darkBg = Color(0xFF0F0F10);
  static const surface = Color(0xFF17171A);
  static const gold = Color(0xFFC9A227);
  static const textMain = Color(0xFFF5F5F5);
  static const textMuted = Color(0xFFB7B7B7);
  static const success = Color(0xFF22C55E);
  static const danger = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);
  static const info = Color(0xFF3B82F6);
  static const premium = Color(0xFFFACC15);
  static const silver = Color(0xFFC0C0C0);
  static const bronze = Color(0xFFCD7F32);

  static ThemeData darkTheme() {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: darkBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: gold,
        brightness: Brightness.dark,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBg,
        foregroundColor: textMain,
        centerTitle: false,
        elevation: 0,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).copyWith(
        headlineLarge: GoogleFonts.oswald(
          textStyle: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: textMain,
          ),
        ),
        headlineMedium: GoogleFonts.oswald(
          textStyle: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: textMain,
          ),
        ),
        titleLarge: GoogleFonts.oswald(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textMain,
          ),
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          color: textMain,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          color: textMuted,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        labelStyle: const TextStyle(color: textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: gold, width: 1.2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: gold.withOpacity(0.18),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: gold,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
