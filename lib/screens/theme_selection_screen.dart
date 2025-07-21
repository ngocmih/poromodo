import 'package:flutter/material.dart';
import '../theme/app_themes.dart';
import 'timer_screen.dart';

class ThemeSelectionScreen extends StatelessWidget {
  final Function(AppTheme) onThemeSelected;

  const ThemeSelectionScreen({super.key, required this.onThemeSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn Tone Màu'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: AppTheme.values.map((theme) {
            return GestureDetector(
              onTap: () {
                onThemeSelected(theme);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TimerScreen(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: appThemeData[theme]?.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Center(
                  child: Text(
                    theme.toString().split('.').last,
                    style: TextStyle(
                      fontSize: 16,
                      color: appThemeData[theme]?.primaryColor ?? Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
