import 'package:flutter/material.dart';
import '../data/theme_controller.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (context, themeMode, child) {
        final isDarkMode = themeMode == ThemeMode.dark;

        return IconButton(
          tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
          onPressed: ThemeController.toggleTheme,
          icon: Icon(
            isDarkMode
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
          ),
        );
      },
    );
  }
}