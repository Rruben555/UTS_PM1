
import 'package:flutter/material.dart';
import './quiz_page.dart';


class ResultPage extends StatelessWidget {
  final String userName;
  final int correctAnswers;
  final int totalQuestions;

  const ResultPage({
    super.key,
    required this.userName,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final int wrongAnswers = totalQuestions - correctAnswers;
    final int score = totalQuestions == 0
        ? 0
        : (correctAnswers / totalQuestions * 100).round();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: const Text('Hasil Kuis'),
        backgroundColor: const Color(0xFFF7F9FC),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                size: 80,
                color: Color(0xFFFFB547),
              ),
              const SizedBox(height: 20),
              Text(
                'Selamat, $userName!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF202B3C),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Kamu telah menyelesaikan kuis.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF7B8798),
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
              const Text(
                'Skor kamu',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7B8798),
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
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7B8798),
                ),
              ),
              const SizedBox(height: 32),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
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
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF7B8798),
            ),
          ),
        ],
      ),
    );
  }
}
