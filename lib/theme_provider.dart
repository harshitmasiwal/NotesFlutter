import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_colors.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isdarkmode = false;

  ThemeProvider() {
    loadTheme(); // Load from SharedPreferences on init
  }

  bool getThemeValue() => _isdarkmode;

  void updatetheme({required bool value}) async {
    _isdarkmode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', _isdarkmode);

    _isdarkmode ? AppColors.setDarkTheme() : AppColors.setLightTheme();
    notifyListeners();
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isdarkmode = prefs.getBool('theme') ?? false;

    _isdarkmode ? AppColors.setDarkTheme() : AppColors.setLightTheme();
    notifyListeners();
  }
}
