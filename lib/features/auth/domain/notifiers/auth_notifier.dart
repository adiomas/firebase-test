import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/common/data/services/local_storage_service.dart';
import 'package:firebase_test/common/domain/providers/base_router_provider.dart';
import 'package:firebase_test/features/auth/data/repositories/auth_repository.dart';
import 'package:firebase_test/features/auth/domain/entities/auth.dart';
import 'package:firebase_test/features/auth/domain/entities/login_type.dart';
import 'package:firebase_test/features/auth/domain/notifiers/auth_state.dart';
import 'package:firebase_test/features/auth/forms/auth_form.dart';
import 'package:firebase_test/features/home/presentation/home_page.dart';
import 'package:firebase_test/features/login/presentation/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier()..checkIfAuthenticated(),
);

class AuthNotifier extends Notifier<AuthState> implements Listenable {
  late final AuthRepository _authRepository;
  late final FormMapper<Auth> _loginFormMapper;
  late final LocalStorageService _localStorageService;
  VoidCallback? _routerListener;
  String? _deepLink;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _loginFormMapper = ref.watch(authFormMapperProvider);
    _localStorageService = ref.watch(localStorageServiceProvider);
    return const AuthState.initial();
  }

  Future<void> checkIfAuthenticated() async {
    await 100.milliseconds;
    ref.read(globalLoadingProvider.notifier).update((_) => true);
    final loginType = await _localStorageService.getLoginType();

    final result = loginType == LoginType.firebase.name
        ? await _authRepository.getUserIfAuthenticatedWithFirebase()
        : await _authRepository.getUserIfAuthenticatedWithSupabase();
    result.fold(
      (failure) {
        ref.read(globalLoadingProvider.notifier).update((_) => false);
        ref.read(globalFailureProvider.notifier).update((_) => failure);
        state = const AuthState.unauthenticated();
        _routerListener?.call();
      },
      (user) {
        ref.read(globalLoadingProvider.notifier).update((_) => false);
        state = user != null
            ? loginType == LoginType.firebase.name
                ? AuthState<User>.authenticated(
                    user as User,
                  )
                : AuthState<supabase.User>.authenticated(
                    user as supabase.User,
                  )
            : const AuthState.unauthenticated();
        _routerListener?.call();
      },
    );
  }

  void submitLoginForm({
    required Map<String, dynamic> formMap,
    required LoginType loginType,
  }) {
    final auth = _loginFormMapper(formMap);
    loginType == LoginType.firebase
        ? loginWithFirebase(
            email: auth.email,
            password: auth.password,
            loginType: loginType,
          )
        : loginWithSupabase(
            email: auth.email,
            password: auth.password,
            loginType: loginType,
          );
  }

  Future<void> loginWithFirebase({
    required String email,
    required String password,
    required LoginType loginType,
  }) async {
    ref.read(globalLoadingProvider.notifier).update((_) => true);
    state = const AuthState.authenticating();
    final result = await _authRepository.loginWithFirebase(
      email: email,
      password: password,
      loginType: loginType,
    );
    result.fold(
      (failure) {
        ref.read(globalLoadingProvider.notifier).update((_) => false);
        ref.read(globalFailureProvider.notifier).update((_) => failure);
        state = const AuthState.unauthenticated();
        _routerListener?.call();
      },
      (user) {
        ref.read(globalLoadingProvider.notifier).update((_) => false);
        state = AuthState<User>.authenticated(user);
        _routerListener?.call();
      },
    );
  }

  Future<void> loginWithSupabase({
    required String email,
    required String password,
    required LoginType loginType,
  }) async {
    ref.read(globalLoadingProvider.notifier).update((_) => true);
    state = const AuthState.authenticating();
    final result = await _authRepository.loginWithSupabase(
      email: email,
      password: password,
      loginType: loginType,
    );
    result.fold(
      (failure) {
        ref.read(globalLoadingProvider.notifier).update((_) => false);
        ref.read(globalFailureProvider.notifier).update((_) => failure);
        state = const AuthState.unauthenticated();
        _routerListener?.call();
      },
      (user) {
        ref.read(globalLoadingProvider.notifier).update((_) => false);
        state = AuthState<supabase.User>.authenticated(user);
        _routerListener?.call();
      },
    );
  }

  Future<void> logout() async {
    ref.read(globalLoadingProvider.notifier).update((_) => true);
    await _authRepository.logout();
    ref.read(globalLoadingProvider.notifier).update((_) => false);
    state = const AuthState.unauthenticated();
    _routerListener?.call();
  }

  String? redirect({
    required GoRouterState state,
    required bool showErrorIfNonExistentRoute,
  }) {
    final isAuthenticating = switch (this.state) {
      AuthStateInitial() || AuthStateAuthenticating() => true,
      _ => false,
    };
    if (isAuthenticating) return null;
    final isLoggedIn = switch (this.state) {
      AuthStateAuthenticated() => true,
      _ => false,
    };
    final routeExists =
        ref.read(baseRouterProvider).routeExists(state.matchedLocation);
    final loginRoutes = state.matchedLocation.startsWith(LoginPage.routeName);
    final loggingIn = state.matchedLocation == LoginPage.routeName;
    if (loggingIn) {
      if (isLoggedIn) {
        if (_deepLink != null) {
          final tmpDeepLink = _deepLink;
          _deepLink = null;
          return tmpDeepLink;
        }
        return HomePage.routeName;
      }
      return null;
    }
    if (isLoggedIn && routeExists) {
      return loginRoutes ? HomePage.routeName : null;
    }
    _deepLink = !loginRoutes && routeExists ? state.matchedLocation : null;
    return loginRoutes || (showErrorIfNonExistentRoute && !routeExists)
        ? null
        : LoginPage.routeName;
  }

  @override
  void addListener(VoidCallback listener) => _routerListener = listener;

  @override
  void removeListener(VoidCallback listener) => _routerListener = null;
}
