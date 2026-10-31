import 'package:flutter/material.dart';

abstract final class AppColors {
  static const bg = Color(0xFFF4F0E6);
  static const ink = Color(0xFF111111);
  static const surface = Color(0xFFFFFFFF);
  static const subtle = Color(0xFF555555);
  static const lime = Color(0xFFD7FF3F);
  static const pink = Color(0xFFFF8FB1);
  static const yellow = Color(0xFFFFC857);
  static const sky = Color(0xFF9ED8FF);
}

abstract final class AppSpace {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
}

abstract final class AppBrutal {
  static const double border = 2;
  static const Offset shadowOffset = Offset(3, 3);
}

abstract final class AppBreakpoints {
  static const double tablet = 600;
  static const double desktop = 1024;
}
