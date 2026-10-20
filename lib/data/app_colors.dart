import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color border;
  final Color track;
  final Color chip;
  final Color letterText;
  final Color accentSoft;
  final Color accentSoftText;
  final Color selectedBg;
  final Color warnBg;
  final Color warnText;

  const AppColors._({
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.border,
    required this.track,
    required this.chip,
    required this.letterText,
    required this.accentSoft,
    required this.accentSoftText,
    required this.selectedBg,
    required this.warnBg,
    required this.warnText,
  });

  static const AppColors light = AppColors._(
    background: Color(0xFFF7F9FC),
    surface: Colors.white,
    textPrimary: Color(0xFF202B3C),
    textSecondary: Color(0xFF7B8798),
    textHint: Color(0xFF9AA5B4),
    border: Color(0xFFE2E8F0),
    track: Color(0xFFE5EAF0),
    chip: Color(0xFFF0F3F7),
    letterText: Color(0xFF64748B),
    accentSoft: Color(0xFFE1F7F3),
    accentSoftText: Color(0xFF138A86),
    selectedBg: Color(0xFFE8F8F6),
    warnBg: Color(0xFFFFF2D8),
    warnText: Color(0xFFB7791F),
  );

  static const AppColors dark = AppColors._(
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    textPrimary: Color(0xFFE8ECF2),
    textSecondary: Color(0xFFA3AEBD),
    textHint: Color(0xFF7B8798),
    border: Color(0xFF2F3640),
    track: Color(0xFF2A303A),
    chip: Color(0xFF2A303A),
    letterText: Color(0xFFB4BECC),
    accentSoft: Color(0xFF16332F),
    accentSoftText: Color(0xFF5FD3CD),
    selectedBg: Color(0xFF15302D),
    warnBg: Color(0xFF3A2F17),
    warnText: Color(0xFFF0C066),
  );

  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>() ?? light;
  }

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
    Color? border,
    Color? track,
    Color? chip,
    Color? letterText,
    Color? accentSoft,
    Color? accentSoftText,
    Color? selectedBg,
    Color? warnBg,
    Color? warnText,
  }) {
    return AppColors._(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
      border: border ?? this.border,
      track: track ?? this.track,
      chip: chip ?? this.chip,
      letterText: letterText ?? this.letterText,
      accentSoft: accentSoft ?? this.accentSoft,
      accentSoftText: accentSoftText ?? this.accentSoftText,
      selectedBg: selectedBg ?? this.selectedBg,
      warnBg: warnBg ?? this.warnBg,
      warnText: warnText ?? this.warnText,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors._(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      border: Color.lerp(border, other.border, t)!,
      track: Color.lerp(track, other.track, t)!,
      chip: Color.lerp(chip, other.chip, t)!,
      letterText: Color.lerp(letterText, other.letterText, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      accentSoftText: Color.lerp(accentSoftText, other.accentSoftText, t)!,
      selectedBg: Color.lerp(selectedBg, other.selectedBg, t)!,
      warnBg: Color.lerp(warnBg, other.warnBg, t)!,
      warnText: Color.lerp(warnText, other.warnText, t)!,
    );
  }
}