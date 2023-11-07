import 'package:firebase_test/common/presentation/app_sizes.dart';
import 'package:firebase_test/common/presentation/image_assets.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_button.dart';
import 'package:firebase_test/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FirebaseTestDialog extends StatelessWidget {
  final Widget child;
  final bool withCloseButton;

  const FirebaseTestDialog._({
    required this.child,
    this.withCloseButton = true,
  });

  static Future<bool?> show(
    BuildContext context, {
    required Widget child,
    bool withCloseButton = true,
  }) {
    return showDialog<bool>(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      barrierColor: CustomColors.baseBlack.withOpacity(0.8),
      builder: (context) => FirebaseTestDialog._(
        withCloseButton: withCloseButton,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: AppSizes.spacing16,
        right: AppSizes.spacing16,
        top: AppSizes.spacing50,
      ),
      child: Column(
        children: [
          SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppSizes.borderRadius16)),
                color: CustomColors.baseWhite,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppSizes.spacing16),
                  if (withCloseButton) ...[
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: AppSizes.spacing16),
                      child: FirebaseTestButton(
                        onTap: Navigator.of(context).pop,
                        child: SvgPicture.asset(
                          ImageAssets.closeIcon,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spacing8),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppSizes.spacing24,
                      right: AppSizes.spacing24,
                      bottom: AppSizes.spacing24,
                    ),
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
