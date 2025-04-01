import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark }

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(_getInitialTheme());

  static ThemeData _getInitialTheme() {
    return ThemeData.light();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = state.brightness == Brightness.dark;
    state = isDark ? ThemeData.light() : ThemeData.dark();
    await prefs.setBool('isDarkTheme', !isDark);
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkTheme') ?? false;
    state = isDark ? ThemeData.dark() : ThemeData.light();
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

extension ThemeExt on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
