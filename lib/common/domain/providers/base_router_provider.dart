// ignore_for_file: always_use_package_imports

import 'package:firebase_test/common/domain/router/go_router_router.dart';
import 'package:firebase_test/common/domain/router/routes.dart';
import 'package:firebase_test/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:firebase_test/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../router/base_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final baseRouterProvider = Provider<BaseRouter>((ref) {
  final authNotifier = ref.read(authNotifierProvider.notifier);
  final goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: HomePage.routeName,
    routes: getRoutes(rootNavigatorKey: _rootNavigatorKey, stateful: true),
    refreshListenable: authNotifier,
    redirect: (context, state) =>
        authNotifier.redirect(state: state, showErrorIfNonExistentRoute: true),
  );
  return GoRouterRouter(
    routerDelegate: goRouter.routerDelegate,
    routeInformationParser: goRouter.routeInformationParser,
    routeInformationProvider: goRouter.routeInformationProvider,
    router: goRouter,
  );
});
