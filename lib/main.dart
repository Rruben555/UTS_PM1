import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/quiz_page.dart';
import 'pages/result_page.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'quiz_app',
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF16A6A1),
          primary: const Color(0xFF16A6A1),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
