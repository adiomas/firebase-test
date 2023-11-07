import 'package:firebase_test/common/presentation/app_sizes.dart';
import 'package:firebase_test/common/presentation/image_assets.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_button.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_text.dart';
import 'package:firebase_test/common/presentation/widgets/small_loading_indicator.dart';
import 'package:firebase_test/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reusable_widgets_docs_generator/reusable_widgets_docs_generator.dart';

@ReusableWidget()
class ActionButton extends StatelessWidget {
  final String title;
  final int titleMaxLines;
  final String? iconPath;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color textColor;
  final bool isLoading;
  final bool hasArrowRight;
  final bool isCentered;
  final Color? leftVerticalLineColor;
  final Widget? badge;

  const ActionButton._({
    required this.title,
    required this.titleMaxLines,
    this.iconPath,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    required this.textColor,
    required this.isLoading,
    required this.hasArrowRight,
    required this.isCentered,
    this.badge,
    this.leftVerticalLineColor,
  });

  factory ActionButton.primary({
    required String title,
    int titleMaxLines = 1,
    String? iconPath,
    required VoidCallback? onTap,
    bool isLoading = false,
    bool hasArrowRight = true,
    Widget? badge,
    bool isCentered = false,
    Color? backgroundColor,
  }) =>
      ActionButton._(
        title: title,
        titleMaxLines: titleMaxLines,
        iconPath: iconPath,
        onTap: onTap,
        backgroundColor: backgroundColor ?? CustomColors.primaryDefault,
        textColor: CustomColors.baseWhite,
        isLoading: isLoading,
        hasArrowRight: hasArrowRight,
        badge: badge,
        isCentered: isCentered,
      );

  factory ActionButton.outline({
    required String title,
    int titleMaxLines = 1,
    String? iconPath,
    required VoidCallback? onTap,
    Color borderColor = CustomColors.primaryDefault,
    bool isLoading = false,
    bool hasArrowRight = true,
    Widget? badge,
    bool isCentered = false,
    Color? leftVerticalLineColor,
  }) =>
      ActionButton._(
        title: title,
        titleMaxLines: titleMaxLines,
        iconPath: iconPath,
        onTap: onTap,
        backgroundColor: CustomColors.baseWhite,
        textColor: CustomColors.primaryDefault,
        borderColor: borderColor,
        isLoading: isLoading,
        hasArrowRight: hasArrowRight,
        badge: badge,
        isCentered: isCentered,
        leftVerticalLineColor: leftVerticalLineColor,
      );

  factory ActionButton.text({
    required String title,
    Color? textColor,
    int titleMaxLines = 1,
    String? iconPath,
    required VoidCallback? onTap,
    bool isLoading = false,
    bool hasArrowRight = true,
    Widget? badge,
    bool isCentered = false,
  }) =>
      ActionButton._(
        title: title,
        titleMaxLines: titleMaxLines,
        iconPath: iconPath,
        onTap: onTap,
        textColor: textColor ?? CustomColors.primaryDefault,
        isLoading: isLoading,
        hasArrowRight: hasArrowRight,
        badge: badge,
        isCentered: isCentered,
      );

  factory ActionButton.disabled({
    required String title,
    int titleMaxLines = 1,
    String? iconPath,
    bool hasArrowRight = true,
    Widget? badge,
    bool isCentered = false,
  }) =>
      ActionButton._(
        title: title,
        titleMaxLines: titleMaxLines,
        iconPath: iconPath,
        onTap: null,
        textColor: CustomColors.baseWhite,
        backgroundColor: CustomColors.grey500,
        isLoading: false,
        hasArrowRight: hasArrowRight,
        badge: badge,
        isCentered: isCentered,
      );

  @override
  Widget build(BuildContext context) {
    return FirebaseTestButton(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Container(
        height: titleMaxLines == 1 ? 48 : null,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.spacing16,
          vertical: titleMaxLines == 1 ? 0 : AppSizes.spacing12,
        ),
        decoration: BoxDecoration(
          gradient: leftVerticalLineColor != null
              ? LinearGradient(
                  stops: const [0.02, 0.02],
                  colors: [
                    leftVerticalLineColor!,
                    backgroundColor ?? Colors.transparent,
                  ],
                )
              : null,
          borderRadius:
              const BorderRadius.all(Radius.circular(AppSizes.borderRadius8)),
          border: borderColor != null
              ? Border.fromBorderSide(BorderSide(color: borderColor!))
              : null,
          color: backgroundColor,
        ),
        child: isLoading
            ? Center(child: SmallLoadingIndicator(color: textColor))
            : Row(
                mainAxisAlignment: hasArrowRight
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: !isCentered
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        if (iconPath != null) ...[
                          SvgPicture.asset(
                            iconPath!,
                            colorFilter:
                                ColorFilter.mode(textColor, BlendMode.srcIn),
                          ),
                          const SizedBox(width: AppSizes.spacing8),
                        ],
                        Flexible(
                          child: FirebaseTestText.extraBoldBody(
                            title,
                            context: context,
                            color: textColor,
                            maxLines: titleMaxLines,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: AppSizes.spacing8),
                          Flexible(child: badge!),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSizes.spacing8),
                  hasArrowRight
                      ? SvgPicture.asset(
                          ImageAssets.chevronRight,
                          colorFilter:
                              ColorFilter.mode(textColor, BlendMode.srcIn),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
      ),
    );
  }
}
