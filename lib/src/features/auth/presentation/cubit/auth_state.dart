part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSignedIn extends AuthState {}

final class AuthSignedOut extends AuthState {}

final class AuthCreatedAccount extends AuthState {}

final class AuthError extends AuthState {
  final Failures failures;
  const AuthError({required this.failures});
}
