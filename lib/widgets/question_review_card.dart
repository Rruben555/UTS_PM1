import 'package:flutter/material.dart';
import '../data/app_colors.dart';
import '../utils/responsive.dart';
import 'answer_row.dart';

class QuestionReviewCard extends StatelessWidget {
  final int number;
  final String question;
  final String correctAnswer;
  final String? selectedAnswer;
  final bool isCorrect;

  const QuestionReviewCard({
    super.key,
    required this.number,
    required this.question,
    required this.correctAnswer,
    required this.selectedAnswer,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final Color statusColor = isCorrect ? AppColors.primary : AppColors.danger;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.sz(16)),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(context.sz(16)),
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
                size: context.sz(20),
              ),
              SizedBox(width: context.sz(8)),
              Text(
                'Soal $number',
                style: TextStyle(
                  fontSize: context.sp(13),
                  fontWeight: FontWeight.w700,
                  color: statusColor,
                ),
              ),
            ],
          ),
          SizedBox(height: context.sz(10)),
          Text(
            question,
            style: TextStyle(
              fontSize: context.sp(15),
              height: 1.4,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
          SizedBox(height: context.sz(12)),
          if (isCorrect)
            AnswerRow(
              label: 'Jawabanmu (Benar)',
              answer: correctAnswer,
              color: AppColors.primary,
            )
          else ...[
            AnswerRow(
              label: 'Jawabanmu',
              answer: selectedAnswer ?? 'Tidak dijawab',
              color: AppColors.danger,
            ),
            SizedBox(height: context.sz(8)),
            AnswerRow(
              label: 'Jawaban benar',
              answer: correctAnswer,
              color: AppColors.primary,
            ),
          ],
        ],
      ),
    );
  }
}
