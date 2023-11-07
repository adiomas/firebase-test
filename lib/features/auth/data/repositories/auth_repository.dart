import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/common/data/generic_error_resolver.dart';
import 'package:firebase_test/common/data/services/local_storage_service.dart';
import 'package:firebase_test/features/auth/data/services/login_service.dart';
import 'package:firebase_test/features/auth/domain/entities/login_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.watch(loginServiceProvider),
    ref.watch(localStorageServiceProvider),
  ),
);

abstract interface class AuthRepository {
  EitherFailureOr<User?> login({
    required String email,
    required String password,
    required LoginType loginType,
  });

  EitherFailureOr<User?> getUserIfAuthenticated();
  EitherFailureOr<void> logout();
}

class AuthRepositoryImpl with ErrorToFailureMixin implements AuthRepository {
  final LoginService _loginService;
  final LocalStorageService _localStorageService;

  AuthRepositoryImpl(this._loginService, this._localStorageService);

  @override
  EitherFailureOr<User?> getUserIfAuthenticated() => execute(
        () async {
          await 1.seconds;
          final loginType = await _localStorageService.getLoginType();
          if (loginType != null) {
            final user = await _loginService.getCurrentlySignedInUser(
              loginType: loginType,
            );
            return Right(user);
          }
          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );

  @override
  EitherFailureOr<User?> login({
    required String email,
    required String password,
    required LoginType loginType,
  }) =>
      execute(
        () async {
          final user = loginType == LoginType.firebase
              ? await _loginService.loginWithFirebase(
                  email: email,
                  password: password,
                )
              : const Right(null);
          if (user != null) {
            await _localStorageService.setLoginType(loginType);
            return Right(user as User);
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
          await _loginService.logout();
          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );
}
