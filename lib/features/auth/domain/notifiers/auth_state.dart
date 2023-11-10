import 'package:equatable/equatable.dart';

sealed class AuthState<T> extends Equatable {
  const AuthState();

  const factory AuthState.initial() = AuthStateInitial;
  const factory AuthState.authenticating() = AuthStateAuthenticating;
  const factory AuthState.authenticated(
    T? user,
  ) = AuthStateAuthenticated;

  const factory AuthState.unauthenticated() = AuthStateUnauthenticated;
}

final class AuthStateInitial<T> extends AuthState<T> {
  const AuthStateInitial();

  @override
  List<Object?> get props => [];
}

final class AuthStateAuthenticating<T> extends AuthState<T> {
  const AuthStateAuthenticating();

  @override
  List<Object?> get props => [];
}

final class AuthStateAuthenticated<T> extends AuthState<T> {
  final T? user;
  const AuthStateAuthenticated(this.user);

  @override
  List<Object?> get props => [];
}

final class AuthStateUnauthenticated<T> extends AuthState<T> {
  const AuthStateUnauthenticated();

  @override
  List<Object?> get props => [];
}
