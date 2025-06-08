import 'package:flutter/material.dart';

class AppColors {
  static Color background = Colors.white;
  static Color borderbackground = Colors.black;
  static Color borderLessBackground = Colors.grey.shade700;

  static void setDarkTheme() {
    background = Colors.grey.shade900;
    borderbackground = Colors.white;
    borderLessBackground = Colors.white54;
  }

  static void setLightTheme() {
    background = Colors.white;
    borderbackground = Colors.black;
    borderLessBackground = Colors.grey.shade700;
  }
}
