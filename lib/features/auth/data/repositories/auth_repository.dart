import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/common/data/generic_error_resolver.dart';
import 'package:firebase_test/common/data/services/local_storage_service.dart';
import 'package:firebase_test/features/auth/data/services/login_service.dart';
import 'package:firebase_test/features/auth/domain/entities/login_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.watch(loginServiceProvider),
    ref.watch(localStorageServiceProvider),
  ),
);

abstract interface class AuthRepository {
  EitherFailureOr<User?> loginWithFirebase({
    required String email,
    required String password,
    required LoginType loginType,
  });
  EitherFailureOr<supabase.User?> loginWithSupabase({
    required String email,
    required String password,
    required LoginType loginType,
  });
  EitherFailureOr<User?> getUserIfAuthenticatedWithFirebase();
  EitherFailureOr<supabase.User?> getUserIfAuthenticatedWithSupabase();
  EitherFailureOr<void> logout();
}

class AuthRepositoryImpl with ErrorToFailureMixin implements AuthRepository {
  final LoginService _loginService;
  final LocalStorageService _localStorageService;

  AuthRepositoryImpl(this._loginService, this._localStorageService);

  @override
  EitherFailureOr<User?> getUserIfAuthenticatedWithFirebase() => execute(
        () async {
          await 1.seconds;
          final user = _loginService.getCurrentlySignedInUserFromFirebase();
          return Right(user);
        },
        errorResolver: const GenericErrorResolver(),
      );

  @override
  EitherFailureOr<supabase.User?> getUserIfAuthenticatedWithSupabase() =>
      execute(
        () async {
          await 1.seconds;
          final user = _loginService.getCurrentlySignedInUserFromSupabase();
          return Right(user);
        },
        errorResolver: const GenericErrorResolver(),
      );

  @override
  EitherFailureOr<User?> loginWithFirebase({
    required String email,
    required String password,
    required LoginType loginType,
  }) =>
      execute(
        () async {
          final user = await _loginService.loginWithFirebase(
            email: email,
            password: password,
          );

          if (user != null) {
            await _localStorageService.setLoginType(loginType);
            return Right(user);
          } else {
            return Left(Failure.generic());
          }
        },
        errorResolver: const GenericErrorResolver(),
      );

  @override
  EitherFailureOr<supabase.User?> loginWithSupabase({
    required String email,
    required String password,
    required LoginType loginType,
  }) =>
      execute(
        () async {
          final user = await _loginService.loginWithSupabase(
            email: email,
            password: password,
          );

          if (user != null) {
            await _localStorageService.setLoginType(loginType);
            return Right(user);
          } else {
            return Left(Failure.generic());
          }
        },
        errorResolver: const GenericErrorResolver(),
      );

  @override
  EitherFailureOr<void> logout() async => execute(
        () async {
          await _localStorageService.deleteAll();
          final loginType = await _localStorageService.getLoginType();
          loginType == LoginType.firebase.name
              ? await _loginService.logoutFromFirebase()
              : await _loginService.logoutFromSupabase();

          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );
}
