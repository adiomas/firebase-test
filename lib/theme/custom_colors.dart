import 'package:flutter/material.dart';

abstract class CustomColors {
  static const Color primaryDefault = Color.fromARGB(255, 100, 61, 198);
  static const Color primaryLight = Color(0xFFFDECE2);
  static const Color baseBlack = Color(0xFF111111);
  static const Color baseWhite = Color(0xFFFFFFFF);
  static const Color alertWarning = Color(0xFFD67D21);
  static const Color alertSuccess = Color(0xFFBECD42);
  static const Color alertCritical = Color(0xFFC73624);
  static const Color alertInfo = Color(0xFF4466AC);
  static const Color grey100 = Color(0xFFFAFAFA);
  static const Color grey200 = Color(0xFFF3F3F3);
  static const Color grey500 = Color(0xFFB9B9B9);
  static const Color grey800 = Color(0xFF55565A);
  static const Color grey900 = Color(0xFF363636);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryDefault, Color(0xFFFD7C33)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
