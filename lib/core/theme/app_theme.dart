import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_tokens.dart';

abstract final class AppTheme {
  static ThemeData light() {
    const scheme = ColorScheme.light(
      primary: AppColors.ink,
      onPrimary: AppColors.surface,
      secondary: AppColors.lime,
      onSecondary: AppColors.ink,
      surface: AppColors.bg,
      onSurface: AppColors.ink,
      error: Color(0xFFD93025),
    );
    final base = ThemeData(useMaterial3: true, colorScheme: scheme);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bg,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      textTheme: GoogleFonts.cairoTextTheme(
        base.textTheme,
      ).apply(bodyColor: AppColors.ink, displayColor: AppColors.ink),
    );
  }
}
