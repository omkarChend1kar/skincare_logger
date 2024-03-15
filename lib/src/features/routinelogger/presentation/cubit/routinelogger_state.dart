part of 'routinelogger_cubit.dart';

@immutable
sealed class RoutineloggerState {}

final class RoutineloggerInitial extends RoutineloggerState {}

final class RoutineloggerLoading extends RoutineloggerState {}

final class RoutineloggerComplete extends RoutineloggerState {
  final List<SkinCareRoutine> skinCareRoutine;

  RoutineloggerComplete({required this.skinCareRoutine});
}

final class RoutineloggerError extends RoutineloggerState {
  final Failures failures;
  RoutineloggerError({required this.failures});
}
