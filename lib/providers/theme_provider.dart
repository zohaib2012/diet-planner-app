import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  String _unitSystem = 'metric'; // metric or imperial

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  String get unitSystem => _unitSystem;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _unitSystem = prefs.getString('unitSystem') ?? 'metric';
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _themeMode == ThemeMode.dark);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', mode == ThemeMode.dark);
    notifyListeners();
  }

  Future<void> setUnitSystem(String system) async {
    _unitSystem = system;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('unitSystem', system);
    notifyListeners();
  }

  // Conversion helpers
  double kgToLbs(double kg) => kg * 2.20462;
  double lbsToKg(double lbs) => lbs / 2.20462;
  double cmToFtIn(double cm) => cm / 30.48;
  String cmToFtInString(double cm) {
    int totalInches = (cm / 2.54).round();
    int feet = totalInches ~/ 12;
    int inches = totalInches % 12;
    return "$feet'$inches\"";
  }
  double mlToOz(double ml) => ml * 0.033814;

  String formatWeight(double kg) {
    if (_unitSystem == 'imperial') {
      return '${kgToLbs(kg).toStringAsFixed(1)} lbs';
    }
    return '${kg.toStringAsFixed(1)} kg';
  }

  String formatHeight(double cm) {
    if (_unitSystem == 'imperial') {
      return cmToFtInString(cm);
    }
    return '${cm.toStringAsFixed(0)} cm';
  }
}
