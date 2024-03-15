part of 'logskincare_cubit.dart';

sealed class LogskincareState extends Equatable {
  const LogskincareState();

  @override
  List<Object> get props => [];
}

final class LogskincareInitial extends LogskincareState {}

final class LogskincareLoading extends LogskincareState {}

final class LogskincareComplete extends LogskincareState {}

final class LogskincareError extends LogskincareState {
  final Failures failures;
  const LogskincareError({required this.failures});
}
