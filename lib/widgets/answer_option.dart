import 'package:flutter/material.dart';
import '../data/app_colors.dart';
import '../utils/responsive.dart';

class AnswerOption extends StatelessWidget {
  final String letter;
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.letter,
    required this.answer,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final double radius = context.sz(15);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: context.sz(14),
          vertical: context.sz(15),
        ),
        decoration: BoxDecoration(
          color: isSelected ? c.selectedBg : c.surface,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: isSelected ? AppColors.primary : c.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: context.sz(36),
              height: context.sz(36),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : c.chip,
                borderRadius: BorderRadius.circular(context.sz(10)),
              ),
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: context.sp(14),
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : c.letterText,
                ),
              ),
            ),
            SizedBox(width: context.sz(14)),
            Expanded(
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: context.sp(15),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: c.textPrimary,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: context.sz(22),
              ),
          ],
        ),
      ),
    );
  }
}
