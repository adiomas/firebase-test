import 'package:firebase_test/common/presentation/app_sizes.dart';
import 'package:firebase_test/common/presentation/build_context_extensions.dart';
import 'package:firebase_test/common/presentation/widgets/action_button.dart';
import 'package:firebase_test/common/presentation/widgets/firebase_test_text.dart';
import 'package:firebase_test/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:firebase_test/features/auth/domain/notifiers/auth_state.dart';
import 'package:firebase_test/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  static const routeName = '/settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authNotifierProvider);
    return switch (state) {
      AuthStateAuthenticated(user: final user) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FirebaseTestText.extraBoldLarge(
                'Email: ${user?.email}',
                context: context,
                color: context.appColors.secondary,
              ),
              const SizedBox(height: AppSizes.borderRadius16),
              SizedBox(
                width: 200,
                child: ActionButton.primary(
                  onTap: () async {
                    await ref.read(authNotifierProvider.notifier).logout();
                  },
                  title: S.current.logout,
                  badge: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  hasArrowRight: false,
                  isCentered: true,
                ),
              ),
            ],
          ),
        ),
      _ => const SizedBox(),
    };
  }
}


//  ListView.separated(

//       itemBuilder: (context, index) => _buildUserItem(context, ref, index),
//       children: [
//         Text(
//           'Users',
//           style: context.appTextStyles.boldLarge,
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: AppSizes.normalSpacing),
//         TextButton(
//           onPressed: () => ref.pushNamed(
//             ref.getRouteNameFromCurrentLocation(
//               UserDetailsPage.getRouteNameWithParams(1, optional: 'abc'),
//             ),
//           ),
//           child: Text(
//             'User 1',
//             style: context.appTextStyles.bold,
//           ),
//         ),
//         const SizedBox(height: AppSizes.normalSpacing),
//         TextButton(
//           onPressed: () => ref.pushNamed(
//             ref.getRouteNameFromCurrentLocation(
//               UserDetailsPage.getRouteNameWithParams(2),
//               keepExistingQueryString: false,
//             ),
//           ),
//           child: Text(
//             'User 2',
//             style: context.appTextStyles.bold,
//           ),
//         ),
//         const SizedBox(height: AppSizes.normalSpacing),
//         TextButton(
//           onPressed: () => ref.pushNamed(
//             '${SettingsPage.routeName}${UserDetailsPage.routeName.replaceAll(UserDetailsPage.pathPattern, 'R')}',
//           ),
//           child: Text(
//             'User R',
//             style: context.appTextStyles.bold,
//           ),
//         ),
//       ],
//     );
