import 'package:flutter/material.dart';

final class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle? semiBoldDisplay;
  final TextStyle? semiBoldExtraLarge;
  final TextStyle? semiBoldLarge;
  final TextStyle? semiBoldMedium;
  final TextStyle? semiBoldBody;
  final TextStyle? semiBoldSmall;
  final TextStyle? semiBoldTiny;
  final TextStyle? extraBoldDisplay;
  final TextStyle? extraBoldExtraLarge;
  final TextStyle? extraBoldLarge;
  final TextStyle? extraBoldMedium;
  final TextStyle? extraBoldBody;
  final TextStyle? extraBoldSmall;
  final TextStyle? extraBoldTiny;

  AppTextStyles({
    required this.semiBoldDisplay,
    required this.semiBoldExtraLarge,
    required this.semiBoldLarge,
    required this.semiBoldMedium,
    required this.semiBoldBody,
    required this.semiBoldSmall,
    required this.semiBoldTiny,
    required this.extraBoldDisplay,
    required this.extraBoldExtraLarge,
    required this.extraBoldLarge,
    required this.extraBoldMedium,
    required this.extraBoldBody,
    required this.extraBoldSmall,
    required this.extraBoldTiny,
  });

  @override
  AppTextStyles copyWith({
    TextStyle? semiBoldDisplay,
    TextStyle? semiBoldExtraLarge,
    TextStyle? semiBoldLarge,
    TextStyle? semiBoldMedium,
    TextStyle? semiBoldBody,
    TextStyle? semiBoldSmall,
    TextStyle? semiBoldTiny,
    TextStyle? extraBoldDisplay,
    TextStyle? extraBoldExtraLarge,
    TextStyle? extraBoldLarge,
    TextStyle? extraBoldMedium,
    TextStyle? extraBoldBody,
    TextStyle? extraBoldSmall,
    TextStyle? extraBoldTiny,
  }) {
    return AppTextStyles(
      semiBoldDisplay: semiBoldDisplay ?? this.semiBoldDisplay,
      semiBoldExtraLarge: semiBoldExtraLarge ?? this.semiBoldExtraLarge,
      semiBoldLarge: semiBoldLarge ?? this.semiBoldLarge,
      semiBoldMedium: semiBoldMedium ?? this.semiBoldMedium,
      semiBoldBody: semiBoldBody ?? this.semiBoldBody,
      semiBoldSmall: semiBoldSmall ?? this.semiBoldSmall,
      semiBoldTiny: semiBoldTiny ?? this.semiBoldTiny,
      extraBoldDisplay: extraBoldDisplay ?? this.extraBoldDisplay,
      extraBoldExtraLarge: extraBoldExtraLarge ?? this.extraBoldExtraLarge,
      extraBoldLarge: extraBoldLarge ?? this.extraBoldLarge,
      extraBoldMedium: extraBoldMedium ?? this.extraBoldMedium,
      extraBoldBody: extraBoldBody ?? this.extraBoldBody,
      extraBoldSmall: extraBoldSmall ?? this.extraBoldSmall,
      extraBoldTiny: extraBoldTiny ?? this.extraBoldTiny,
    );
  }

  @override
  AppTextStyles lerp(AppTextStyles? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    }
    return AppTextStyles(
      semiBoldDisplay:
          TextStyle.lerp(semiBoldDisplay, other.semiBoldDisplay, t),
      semiBoldExtraLarge:
          TextStyle.lerp(semiBoldExtraLarge, other.semiBoldExtraLarge, t),
      semiBoldLarge: TextStyle.lerp(semiBoldLarge, other.semiBoldLarge, t),
      semiBoldMedium: TextStyle.lerp(semiBoldMedium, other.semiBoldMedium, t),
      semiBoldBody: TextStyle.lerp(semiBoldBody, other.semiBoldBody, t),
      semiBoldSmall: TextStyle.lerp(semiBoldSmall, other.semiBoldSmall, t),
      semiBoldTiny: TextStyle.lerp(semiBoldTiny, other.semiBoldTiny, t),
      extraBoldDisplay:
          TextStyle.lerp(extraBoldDisplay, other.extraBoldDisplay, t),
      extraBoldExtraLarge:
          TextStyle.lerp(extraBoldExtraLarge, other.extraBoldExtraLarge, t),
      extraBoldLarge: TextStyle.lerp(extraBoldLarge, other.extraBoldLarge, t),
      extraBoldMedium:
          TextStyle.lerp(extraBoldMedium, other.extraBoldMedium, t),
      extraBoldBody: TextStyle.lerp(extraBoldBody, other.extraBoldBody, t),
      extraBoldSmall: TextStyle.lerp(extraBoldSmall, other.extraBoldSmall, t),
      extraBoldTiny: TextStyle.lerp(extraBoldTiny, other.extraBoldTiny, t),
    );
  }
}

AppTextStyles getAppTextStyles({required Color defaultColor}) {
  final baseTextStyle = TextStyle(
    color: defaultColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  return AppTextStyles(
    semiBoldDisplay: baseTextStyle.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 32,
    ),
    semiBoldExtraLarge: baseTextStyle.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
    semiBoldLarge: baseTextStyle.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    semiBoldMedium: baseTextStyle.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    semiBoldBody: baseTextStyle.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    semiBoldSmall: baseTextStyle.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    semiBoldTiny: baseTextStyle.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 10,
    ),
    extraBoldDisplay: baseTextStyle.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 32,
    ),
    extraBoldExtraLarge: baseTextStyle.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 20,
    ),
    extraBoldLarge: baseTextStyle.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 18,
    ),
    extraBoldMedium: baseTextStyle.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 16,
    ),
    extraBoldBody: baseTextStyle.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 14,
    ),
    extraBoldSmall: baseTextStyle.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 12,
    ),
    extraBoldTiny: baseTextStyle.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 10,
    ),
  );
}
