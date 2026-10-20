import 'package:flutter/material.dart';
import '../data/app_colors.dart';
import '../utils/responsive.dart';

/// Kotak berlabel yang menampilkan satu jawaban (milik pengguna / jawaban benar).
class AnswerRow extends StatelessWidget {
  final String label;
  final String answer;
  final Color color;

  const AnswerRow({
    super.key,
    required this.label,
    required this.answer,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.sz(12),
        vertical: context.sz(10),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.sz(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: context.sp(11),
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          SizedBox(height: context.sz(2)),
          Text(
            answer,
            style: TextStyle(
              fontSize: context.sp(14),
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
