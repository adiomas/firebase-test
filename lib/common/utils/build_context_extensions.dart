import 'package:firebase_test/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  AppTextStyles get appTextStyles => Theme.of(this).extension<AppTextStyles>()!;

  bool get isSmallScreen => MediaQuery.sizeOf(this).height <= 600;
}
