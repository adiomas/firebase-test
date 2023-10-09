import 'package:firebase_test/common/domain/router/navigation_extensions.dart';
import 'package:firebase_test/features/auth/domain/entities/user.dart';
import 'package:firebase_test/features/users/presentation/user_details_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserCard extends ConsumerWidget {
  final User user;
  final int id;
  const UserCard({super.key, required this.user, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.pushNamed(
        ref.getRouteNameFromCurrentLocation(
          UserDetailsPage.getRouteNameWithParams(
            id,
          ),
          keepExistingQueryString: true,
        ),
        data: user,
      ),
      child: Container(
        height: 70,
        width: 200,
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.blue.shade50,
          child: Center(
            child: Text(user.name),
          ),
        ),
      ),
    );
  }
}
