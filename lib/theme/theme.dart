import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    return ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF02FFA1),
        brightness: Brightness.dark);
  }
}
