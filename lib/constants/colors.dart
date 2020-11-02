import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const Map<int, Color> orange = const <int, Color>{
    50: const Color(0xFFFCF2E7),
    100: const Color(0xFFF8DEC3),
    200: const Color(0xFFF3C89C),
    300: const Color(0xFFEEB274),
    400: const Color(0xFFEAA256),
    500: const Color(0xFFE69138),
    600: const Color(0xFFE38932),
    700: const Color(0xFFDF7E2B),
    800: const Color(0xFFDB7424),
    900: const Color(0xFFD56217)
  };

  static const Map<int, Color> greenBlue = const <int, Color>{
    50: Color(0xFFE8F6F6),
    100: Color(0xFFC5E7E9),
    200: Color(0xFF9FD8DA),
    300: Color(0xFF79C8CB),
    400: Color(0xFF5CBCC0),
    500: Color(0xFF3FB0B5),
    600: Color(0xFF39A9AE),
    700: Color(0xFF31A0A5),
    800: Color(0xFF29979D),
    900: Color(0xFF1B878D),
  };
  static const Map<int, Color> greenBlueAccent = const <int, Color>{
    100: Color(0xFFC6FBFF),
    200: Color(0xFF93F8FF),
    400: Color(0xFF60F5FF),
    700: Color(0xFF47F4FF),
  };

  static const kTextColor = Color(0xFF3C4046);
}
