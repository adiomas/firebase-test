import 'package:firebase_test/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:q_architecture/q_architecture.dart';

extension GlobalInfoStatusExtension on GlobalInfoStatus {
  Color get textColor {
    switch (this) {
      case GlobalInfoStatus.success:
        return CustomColors.baseBlack;
      default:
        return CustomColors.baseWhite;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case GlobalInfoStatus.success:
        return CustomColors.alertSuccess;
      case GlobalInfoStatus.info:
        return CustomColors.alertInfo;
      case GlobalInfoStatus.warning:
        return CustomColors.alertWarning;
      case GlobalInfoStatus.error:
        return CustomColors.alertCritical;
    }
  }
}
