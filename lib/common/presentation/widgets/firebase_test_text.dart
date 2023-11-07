import 'package:firebase_test/common/presentation/build_context_extensions.dart';
import 'package:flutter/material.dart';

class FirebaseTestText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool centerText;
  final bool underline;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? alignment;
  final TextStyle? textStyle;

  const FirebaseTestText._(
    this.text, {
    this.color,
    this.centerText = false,
    this.underline = false,
    this.maxLines,
    this.overflow,
    this.alignment,
    required this.textStyle,
  });

  factory FirebaseTestText.semiBoldDisplay(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.semiBoldDisplay,
      );

  factory FirebaseTestText.extraBoldDisplay(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.extraBoldDisplay,
      );

  factory FirebaseTestText.semiBoldExtraLarge(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.semiBoldExtraLarge,
      );

  factory FirebaseTestText.extraBoldExtraLarge(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.extraBoldExtraLarge,
      );

  factory FirebaseTestText.semiBoldLarge(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.semiBoldLarge,
      );

  factory FirebaseTestText.extraBoldLarge(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.extraBoldLarge,
      );

  factory FirebaseTestText.semiBoldMedium(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.semiBoldMedium,
      );

  factory FirebaseTestText.extraBoldMedium(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.extraBoldMedium,
      );

  factory FirebaseTestText.semiBoldBody(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.semiBoldBody,
      );

  factory FirebaseTestText.extraBoldBody(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.extraBoldBody,
      );

  factory FirebaseTestText.semiBoldSmall(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.semiBoldSmall,
      );

  factory FirebaseTestText.extraBoldSmall(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.extraBoldSmall,
      );

  factory FirebaseTestText.semiBoldTiny(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.semiBoldTiny,
      );

  factory FirebaseTestText.extraBoldTiny(
    String text, {
    required BuildContext context,
    Color? color,
    bool centerText = false,
    bool underline = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? alignment,
  }) =>
      FirebaseTestText._(
        text,
        color: color,
        alignment: alignment,
        centerText: centerText,
        maxLines: maxLines,
        underline: underline,
        overflow: overflow,
        textStyle: context.appTextStyles.extraBoldTiny,
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle?.copyWith(
        color: color,
        decoration: underline ? TextDecoration.underline : null,
        overflow: overflow,
      ),
      maxLines: maxLines,
      textAlign: centerText ? TextAlign.center : alignment,
    );
  }
}
