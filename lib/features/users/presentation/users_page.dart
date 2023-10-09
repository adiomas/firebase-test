import 'package:firebase_test/features/users/domain/notifiers/users_notifier.dart';
import 'package:firebase_test/features/users/presentation/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:firebase_test/common/presentation/app_sizes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_state_notifier.dart';

class UsersPage extends ConsumerWidget {
  static const routeName = '/users';

  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersProvider = ref.watch(usersNotifierProvider);

    return switch (usersProvider) {
      BaseData(data: final users) => ListView.separated(
          itemBuilder: (context, index) => UserCard(
            user: users[index],
            id: index + 1,
          ),
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSizes.normalSpacing),
          itemCount: users.length,
        ),
      _ => Container(),
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
//             '${UsersPage.routeName}${UserDetailsPage.routeName.replaceAll(UserDetailsPage.pathPattern, 'R')}',
//           ),
//           child: Text(
//             'User R',
//             style: context.appTextStyles.bold,
//           ),
//         ),
//       ],
//     );
