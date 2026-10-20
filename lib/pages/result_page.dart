import 'package:flutter/material.dart';
import '../data/app_colors.dart';
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
      return (
        icon: Icons.emoji_events_rounded,
        color: const Color(0xFFFFB547),
      );
    }
    if (score >= 80) {
      return (
        icon: Icons.sentiment_very_satisfied_rounded,
        color: const Color(0xFF16A6A1),
      );
    }
    if (score >= 60) {
      return (
        icon: Icons.thumb_up_rounded,
        color: const Color(0xFF3B82F6),
      );
    }
    return (
      icon: Icons.sentiment_very_dissatisfied_rounded,
      color: const Color(0xFFE05D5D),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(
                resultIcon.icon,
                size: 80,
                color: resultIcon.color,
              ),
              const SizedBox(height: 20),
              Text(
                'Selamat, $userName!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: c.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Kamu telah menyelesaikan kuis.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: c.textSecondary,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                '$score',
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF16A6A1),
                ),
              ),
              Text(
                'Skor kamu',
                style: TextStyle(
                  fontSize: 16,
                  color: c.textSecondary,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: _ResultCard(
                      title: 'Jawaban Benar',
                      value: '$correctAnswers',
                      color: const Color(0xFF16A6A1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ResultCard(
                      title: 'Jawaban Salah',
                      value: '$wrongAnswers',
                      color: const Color(0xFFE05D5D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Total pertanyaan: $totalQuestions',
                style: TextStyle(
                  fontSize: 14,
                  color: c.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pembahasan Soal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...List.generate(questions.length, (i) {
                final question = questions[i];
                final options = question['options'] as List;
                final int correctIndex = question['correctAnswer'] as int;
                final int? selectedIndex = selectedAnswers[i];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _QuestionReviewCard(
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
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A6A1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Kembali ke Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _ResultCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: c.border,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: c.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionReviewCard extends StatelessWidget {
  final int number;
  final String question;
  final String correctAnswer;
  final String? selectedAnswer; // null = tidak dijawab
  final bool isCorrect;

  const _QuestionReviewCard({
    required this.number,
    required this.question,
    required this.correctAnswer,
    required this.selectedAnswer,
    required this.isCorrect,
  });

  static const Color _green = Color(0xFF16A6A1);
  static const Color _red = Color(0xFFE05D5D);

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final Color statusColor = isCorrect ? _green : _red;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: statusColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Soal $number',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: statusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            question,
            style: TextStyle(
              fontSize: 15,
              height: 1.4,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          if (isCorrect)
            _AnswerRow(
              label: 'Jawabanmu (Benar)',
              answer: correctAnswer,
              color: _green,
            )
          else ...[
            _AnswerRow(
              label: 'Jawabanmu',
              answer: selectedAnswer ?? 'Tidak dijawab',
              color: _red,
            ),
            const SizedBox(height: 8),
            _AnswerRow(
              label: 'Jawaban benar',
              answer: correctAnswer,
              color: _green,
            ),
          ],
        ],
      ),
    );
  }
}

class _AnswerRow extends StatelessWidget {
  final String label;
  final String answer;
  final Color color;

  const _AnswerRow({
    required this.label,
    required this.answer,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            answer,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}