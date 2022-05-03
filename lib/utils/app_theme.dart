/// app_theme.dart
/// A class that stores and sets the colors used throughout the app.
/// @author Jacob Rohde

import 'package:flutter/material.dart';

class AppTheme {
  Color mainColor = const Color.fromARGB(255, 0, 255, 0);
  Color textColor = const Color.fromARGB(255, 0, 255, 0);
  Color backgroundColor = Colors.black;
  Color barColor = Colors.black;
  bool isDark = true;

  switchTheme() {
    if(isDark) {
      mainColor = Colors.blue;
      textColor = Colors.black;
      backgroundColor = Colors.white;
      barColor = Colors.blue;
      isDark = false;
    } else {
      mainColor = const Color.fromARGB(255, 0, 255, 0);
      textColor = const Color.fromARGB(255, 0, 255, 0);
      backgroundColor = Colors.black;
      barColor = Colors.black;
      isDark = true;
    }
  }
}