import 'package:flutter/material.dart';
import '../data/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/primary_button.dart';
import '../widgets/question_review_card.dart';
import '../widgets/responsive_body.dart';
import '../widgets/result_card.dart';
import '../widgets/theme_toggle.dart';

class ResultPage extends StatelessWidget {
  final String userName;
  final int correctAnswers;
  final int totalQuestions;
  final List<Map<String, dynamic>> questions;
  final Map<int, int> selectedAnswers;

  const ResultPage({
    super.key,
    required this.userName,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.questions,
    required this.selectedAnswers,
  });

  /// Icon hasil berdasarkan skor:
  /// < 60 menangis, 60-79 jempol, 80-99 senang, 100 piala.
  ({IconData icon, Color color}) _iconForScore(int score) {
    if (score >= 100) {
      return (icon: Icons.emoji_events_rounded, color: AppColors.gold);
    }
    if (score >= 80) {
      return (
        icon: Icons.sentiment_very_satisfied_rounded,
        color: AppColors.primary,
      );
    }
    if (score >= 60) {
      return (icon: Icons.thumb_up_rounded, color: AppColors.info);
    }
    return (
      icon: Icons.sentiment_very_dissatisfied_rounded,
      color: AppColors.danger,
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final int wrongAnswers = totalQuestions - correctAnswers;
    final int score = totalQuestions == 0
        ? 0
        : (correctAnswers / totalQuestions * 100).round();
    final resultIcon = _iconForScore(score);

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: const Text('Hasil Kuis'),
        backgroundColor: c.background,
        actions: const [
          ThemeToggle(),
        ],
      ),
      body: ResponsiveBody(
        verticalPadding: 24,
        child: Column(
          children: [
            Icon(
              resultIcon.icon,
              size: context.sz(80),
              color: resultIcon.color,
            ),
            SizedBox(height: context.sz(20)),
            Text(
              'Selamat, $userName!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.sp(24),
                fontWeight: FontWeight.bold,
                color: c.textPrimary,
              ),
            ),
            SizedBox(height: context.sz(12)),
            Text(
              'Kamu telah menyelesaikan kuis.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.sp(15),
                color: c.textSecondary,
              ),
            ),
            SizedBox(height: context.sz(28)),
            Text(
              '$score',
              style: TextStyle(
                fontSize: context.sp(64),
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Text(
              'Skor kamu',
              style: TextStyle(
                fontSize: context.sp(16),
                color: c.textSecondary,
              ),
            ),
            SizedBox(height: context.sz(28)),
            Row(
              children: [
                Expanded(
                  child: ResultCard(
                    title: 'Jawaban Benar',
                    value: '$correctAnswers',
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: context.sz(12)),
                Expanded(
                  child: ResultCard(
                    title: 'Jawaban Salah',
                    value: '$wrongAnswers',
                    color: AppColors.danger,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.sz(12)),
            Text(
              'Total pertanyaan: $totalQuestions',
              style: TextStyle(
                fontSize: context.sp(14),
                color: c.textSecondary,
              ),
            ),
            SizedBox(height: context.sz(32)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pembahasan Soal',
                style: TextStyle(
                  fontSize: context.sp(18),
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
            ),
            SizedBox(height: context.sz(12)),
            ...List.generate(questions.length, (i) {
              final question = questions[i];
              final options = question['options'] as List;
              final int correctIndex = question['correctAnswer'] as int;
              final int? selectedIndex = selectedAnswers[i];

              return Padding(
                padding: EdgeInsets.only(bottom: context.sz(12)),
                child: QuestionReviewCard(
                  number: i + 1,
                  question: question['question'] as String,
                  correctAnswer: options[correctIndex].toString(),
                  selectedAnswer: selectedIndex == null
                      ? null
                      : options[selectedIndex].toString(),
                  isCorrect: selectedIndex == correctIndex,
                ),
              );
            }),
            SizedBox(height: context.sz(20)),
            PrimaryButton(
              text: 'Kembali ke Home',
              icon: Icons.home_rounded,
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
