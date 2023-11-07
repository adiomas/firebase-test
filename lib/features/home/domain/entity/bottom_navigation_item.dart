import 'package:flutter/material.dart';
import 'package:firebase_test/features/dashboard/presentation/dashboard_page.dart';
import 'package:firebase_test/features/directories/presentation/directories_page.dart';

enum BottomNavigationItem {
  dashboard(icon: Icons.home, routeName: DashboardPage.routeName),

  settings(icon: Icons.settings, routeName: DirectoriesPage.routeName);

  final IconData icon;
  final String routeName;

  const BottomNavigationItem({required this.icon, required this.routeName});

  String get title => switch (this) {
        dashboard => 'Dashboard',
        settings => 'Settings',
      };

  static int getIndexForLocation(String? location) =>
      BottomNavigationItem.values
          .firstWhere(
            (element) => location?.startsWith(element.routeName) == true,
            orElse: () => BottomNavigationItem.dashboard,
          )
          .index;
}
