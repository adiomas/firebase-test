import 'package:firebase_test/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_test/common/presentation/build_context_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserDetailsPage extends ConsumerWidget {
  static const routeName = '/details/$pathPattern';
  static const pathPattern = ':userId';
  static const queryParameterKey = 'optional';

  static String getRouteNameWithParams(
    int userId, {
    String? optional,
  }) =>
      '${routeName.replaceAll(pathPattern, '$userId')}${optional != null ? '?$queryParameterKey=$optional' : ''}';

  final User user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('User details')),
      body: ListView(
        children: [
          Text(
            'User name: ${user.name}',
            style: context.appTextStyles.boldLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Age: ${user.age}',
            style: context.appTextStyles.boldLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
