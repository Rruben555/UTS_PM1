import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'data/theme_controller.dart';
import 'data/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color _seed = Color(0xFF16A6A1);

  ThemeData _buildTheme(Brightness brightness, AppColors colors) {
    return ThemeData(
      brightness: brightness,
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData(brightness: brightness).textTheme,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seed,
        brightness: brightness,
      ),
      scaffoldBackgroundColor: colors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      extensions: <ThemeExtension<dynamic>>[colors],
      useMaterial3: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (context, currentTheme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: currentTheme,
          theme: _buildTheme(Brightness.light, AppColors.light),
          darkTheme: _buildTheme(Brightness.dark, AppColors.dark),
          home: const HomePage(),
        );
      },
    );
  }
}