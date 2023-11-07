// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_test/common/presentation/app_sizes.dart';
import 'package:firebase_test/common/presentation/image_assets.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_button.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_text.dart';
import 'package:firebase_test/common/utils/global_info_status_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

class FirebaseTestFlushbar {
  static final FirebaseTestFlushbar _FirebaseTestFlushbar =
      FirebaseTestFlushbar._internal();
  static const _flushbarDurationInSeconds = 5;
  static Timer? _flushbarDismissTimer;

  Flushbar? _flushbar;

  factory FirebaseTestFlushbar() {
    return _FirebaseTestFlushbar;
  }

  FirebaseTestFlushbar._internal();

  Future<void> showFlushbar({
    required BuildContext context,
    required WidgetRef ref,
    required String message,
    GlobalInfoStatus globalInfoStatus = GlobalInfoStatus.error,
  }) async {
    if (_flushbar != null) return;
    _flushbar = Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius:
          const BorderRadius.all(Radius.circular(AppSizes.borderRadius8)),
      backgroundColor: globalInfoStatus.backgroundColor,
      borderWidth: 2,
      margin: EdgeInsets.only(
        left: AppSizes.spacing20,
        right: AppSizes.spacing20,
        bottom: AppSizes.spacing16,
      ),
      messageText: FirebaseTestText.semiBoldSmall(
        message,
        context: context,
        color: globalInfoStatus.textColor,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
      mainButton: FirebaseTestButton(
        onTap: _dismissFlushbar,
        child: SvgPicture.asset(
          ImageAssets.closeIcon,
          colorFilter:
              ColorFilter.mode(globalInfoStatus.textColor, BlendMode.srcIn),
        ),
      ),
      padding: const EdgeInsets.all(AppSizes.spacing16),
      duration: const Duration(seconds: _flushbarDurationInSeconds),
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED) {
          _flushbar = null;
          _flushbarDismissTimer?.cancel();
        }
      },
    )..show(context);
    _flushbarDismissTimer = Timer(
      const Duration(seconds: _flushbarDurationInSeconds + 3),
      () {
        if (_flushbar != null) {
          _flushbar = null;
        }
      },
    );
  }

  Future<void> _dismissFlushbar() async {
    await _flushbar?.dismiss();
    _flushbar = null;
  }
}
