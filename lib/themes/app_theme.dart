import 'package:flutter/material.dart';

class AppTheme {
  // Paleta inspirada en Colombia
  static const Color amarillo = Color(0xFFFCD116);
  static const Color azul = Color(0xFF003893);
  static const Color rojo = Color(0xFFCE1126);
  static const Color fondo = Color(0xFFF5F7FA);
  static const Color superficie = Color(0xFFFFFFFF);
  static const Color textoOscuro = Color(0xFF1A1A2E);
  static const Color textoGris = Color(0xFF6B7280);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: azul,
        primary: azul,
        secondary: amarillo,
        tertiary: rojo,
        surface: superficie,
        onPrimary: Colors.white,
        onSecondary: textoOscuro,
      ),
      scaffoldBackgroundColor: fondo,
      appBarTheme: AppBarTheme(
        backgroundColor: azul,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: superficie,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: textoOscuro,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textoOscuro,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textoOscuro,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textoGris,
          height: 1.5,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
          color: textoGris,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: Color(0xFFE5E7EB),
        thickness: 1,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: azul,
      ),
    );
  }
}
