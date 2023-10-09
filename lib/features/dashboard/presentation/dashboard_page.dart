import 'package:firebase_test/common/presentation/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_test/common/domain/router/navigation_extensions.dart';
import 'package:firebase_test/common/presentation/build_context_extensions.dart';
import 'package:firebase_test/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:firebase_test/features/users/presentation/user_details_page.dart';
import 'package:firebase_test/features/users/presentation/users_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardPage extends ConsumerWidget {
  static const routeName = '/dashboard';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Text(
          'Dashboard',
          style: context.appTextStyles.boldLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.normalSpacing),
        TextButton(
          onPressed: ref.read(authNotifierProvider.notifier).logout,
          child: Text(
            'Logout',
            style: context.appTextStyles.regular,
          ),
        ),
        const SizedBox(height: AppSizes.normalSpacing),
        TextButton(
          onPressed: () => ref.pushNamed(
            ref.getRouteNameFromCurrentLocation(
              UserDetailsPage.getRouteNameWithParams(1),
            ),
          ),
          child: Text(
            'Dashboard -> User details 1',
            style: context.appTextStyles.bold,
          ),
        ),
        const SizedBox(height: AppSizes.normalSpacing),
        TextButton(
          onPressed: () => ref.pushNamed(
            '${UsersPage.routeName}${UserDetailsPage.getRouteNameWithParams(1)}',
          ),
          child: Text(
            'Users -> User details 1',
            style: context.appTextStyles.bold,
          ),
        ),
      ],
    );
  }
}
