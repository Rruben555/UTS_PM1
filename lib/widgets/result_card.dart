import 'package:flutter/material.dart';
import '../data/app_colors.dart';
import '../utils/responsive.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const ResultCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);

    return Container(
      padding: EdgeInsets.all(context.sz(16)),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(context.sz(16)),
        border: Border.all(color: c.border),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: context.sp(28),
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: context.sz(8)),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.sp(13),
              color: c.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
