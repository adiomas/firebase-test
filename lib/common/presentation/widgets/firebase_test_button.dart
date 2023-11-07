import 'package:firebase_test/common/presentation/app_sizes.dart';
import 'package:flutter/cupertino.dart';

class FirebaseTestButton extends StatelessWidget {
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final Widget child;

  const FirebaseTestButton({
    super.key,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSizes.spacing8),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.8,
      onPressed: onTap,
      padding: padding,
      minSize: 0,
      child: child,
    );
  }
}
