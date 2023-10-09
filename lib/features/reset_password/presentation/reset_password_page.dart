import 'package:flutter/material.dart';
import 'package:firebase_test/common/domain/router/navigation_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPasswordPage extends ConsumerWidget {
  static const routeName = '/reset-password';

  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: ListView(
        children: [
          TextButton(
            onPressed: ref.pop,
            child: const Text('Go back'),
          ),
        ],
      ),
    );
  }
}
