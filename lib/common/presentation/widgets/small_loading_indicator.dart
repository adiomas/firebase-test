import 'package:firebase_test/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class SmallLoadingIndicator extends StatelessWidget {
  final Color? color;

  const SmallLoadingIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(
        color: color ?? CustomColors.primaryDefault,
        strokeWidth: 3,
      ),
    );
  }
}
