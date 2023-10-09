import 'package:flutter/material.dart';
import 'package:firebase_test/features/dashboard/presentation/dashboard_page.dart';
import 'package:firebase_test/features/directories/presentation/directories_page.dart';
import 'package:firebase_test/features/notifications/presentation/notifications_page.dart';
import 'package:firebase_test/features/users/presentation/users_page.dart';

enum BottomNavigationItem {
  dashboard(icon: Icons.home, routeName: DashboardPage.routeName),
  users(icon: Icons.account_circle, routeName: UsersPage.routeName),
  notifications(icon: Icons.add_alert, routeName: NotificationsPage.routeName),
  directories(icon: Icons.folder, routeName: DirectoriesPage.routeName);

  final IconData icon;
  final String routeName;

  const BottomNavigationItem({required this.icon, required this.routeName});

  String get title => switch (this) {
        dashboard => 'Dashboard',
        users => 'Users',
        notifications => 'Notifications',
        directories => 'Directories',
      };

  static int getIndexForLocation(String? location) =>
      BottomNavigationItem.values
          .firstWhere(
            (element) => location?.startsWith(element.routeName) == true,
            orElse: () => BottomNavigationItem.dashboard,
          )
          .index;
}
