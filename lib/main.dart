import 'package:flutter/material.dart';
import 'screens/theme_selection_screen.dart';
import 'theme/app_themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTheme _selectedTheme = AppTheme.Light;

  void _setTheme(AppTheme theme) {
    setState(() {
      _selectedTheme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation Timer',
      theme: appThemeData[_selectedTheme],
      home: ThemeSelectionScreen(onThemeSelected: _setTheme),
    );
  }
}
