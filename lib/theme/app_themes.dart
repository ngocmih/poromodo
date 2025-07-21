import 'package:flutter/material.dart';

enum AppTheme { Light, Green, Purple, Dark }

final appThemeData = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
  ),
  AppTheme.Green: ThemeData(
    scaffoldBackgroundColor: Color(0xFFE8F5E9),
    primaryColor: Colors.green[800],
  ),
  AppTheme.Purple: ThemeData(
    scaffoldBackgroundColor: Color(0xFFF3E5F5),
    primaryColor: Colors.deepPurple,
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.white,
  ),
};
