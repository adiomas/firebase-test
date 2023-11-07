import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_test/features/dashboard/presentation/dashboard_page.dart';
import 'package:firebase_test/features/home/presentation/home_page.dart';
import 'package:firebase_test/features/login/presentation/login_page.dart';

import 'package:firebase_test/features/settings/presentation/settings_page.dart';

List<RouteBase> getRoutes({
  required GlobalKey<NavigatorState> rootNavigatorKey,
  bool stateful = true,
}) =>
    [
      GoRoute(
        path: HomePage.routeName,
        redirect: (context, state) => DashboardPage.routeName,
      ),
      if (stateful)
        _statefulShellRoute(rootNavigatorKey: rootNavigatorKey)
      else
        _shellRoute(rootNavigatorKey: rootNavigatorKey),
      GoRoute(
        path: LoginPage.routeName,
        builder: (context, state) => const LoginPage(),
      ),
    ];

RouteBase _statefulShellRoute({
  required GlobalKey<NavigatorState> rootNavigatorKey,
}) =>
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomePage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: DashboardPage.routeName,
            builder: (context, state) => const DashboardPage(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: SettingsPage.routeName,
            builder: (context, state) => const SettingsPage(),
          ),
        ]),
      ],
    );

RouteBase _shellRoute({required GlobalKey<NavigatorState> rootNavigatorKey}) =>
    ShellRoute(
      builder: (context, state, child) => HomePage(child: child),
      routes: [
        GoRoute(
          path: DashboardPage.routeName,
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: SettingsPage.routeName,
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    );
