import 'package:flutter/material.dart';
import '../data/app_colors.dart';
import '../utils/responsive.dart';

/// Tombol outline. Jika [onPressed] null, tombol tampil nonaktif.
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final bool enabled = onPressed != null;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: Colors.grey,
          padding: EdgeInsets.symmetric(vertical: context.sz(16)),
          side: BorderSide(color: enabled ? AppColors.primary : c.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.sz(16)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: context.sz(20)),
              SizedBox(width: context.sz(10)),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: context.sp(16),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
