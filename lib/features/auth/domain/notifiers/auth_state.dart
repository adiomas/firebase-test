import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/features/auth/domain/entities/login_type.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  const factory AuthState.initial() = AuthStateInitial;
  const factory AuthState.authenticating(LoginType loginType) =
      AuthStateAuthenticating;
  const factory AuthState.authenticated(
    User? user,
  ) = AuthStateAuthenticated;
  const factory AuthState.unauthenticated() = AuthStateUnauthenticated;
}

final class AuthStateInitial extends AuthState {
  const AuthStateInitial();

  @override
  List<Object?> get props => [];
}

final class AuthStateAuthenticating extends AuthState {
  final LoginType loginType;
  const AuthStateAuthenticating(this.loginType);

  @override
  List<Object?> get props => [loginType];
}

final class AuthStateAuthenticated extends AuthState {
  final User? user;
  const AuthStateAuthenticated(this.user);

  @override
  List<Object?> get props => [];
}

final class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();

  @override
  List<Object?> get props => [];
}
