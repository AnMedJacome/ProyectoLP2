import 'package:flutter/material.dart';

// REEMPLAZAR COLORES
class AppColors {
  static MaterialColor mainColor = const MaterialColor(
    0xFFF3CC44,
     <int, Color>{
      50: Color(0xFFF3CC44),
      100: Color(0xFFF3CC44),
      200: Color(0xFFF3CC44),
      300: Color(0xFFF3CC44),
      400: Color(0xFFF3CC44),
      500: Color(0xFFF3CC44),
      600: Color(0xFFF3CC44),
      700: Color(0xFFF3CC44),
      800: Color(0xFFF3CC44),
      900: Color(0xFFF3CC44),
    },
  );

  //static const PrimaryColor = Color(0xFF0C4B8D);
  static const primaryColor = Color(0xFFF3CC44);

  static const Color yellow = Color(0xFFEEC415);
  static const Color green = Color(0xFF61BF33);
  static const Color orange = Color(0xFFE96B1A);
  static const Color red = Color(0xFFDF1919);
  static const Color background = Colors.white24;

  static const Color text_light = Colors.black87;
  static const Color text_dark = Colors.white;

  // Shimmer Colors
  static final Color shimmerBackground = Colors.grey.shade300;
  static final Color shimmerBaseColor = Colors.grey.shade300;
  static final Color shimmerHighlightColor = Colors.grey.shade100;
}
