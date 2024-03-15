part of 'getstreakdata_cubit.dart';

sealed class GetstreakdataState extends Equatable {
  const GetstreakdataState();

  @override
  List<Object> get props => [];
}

final class GetstreakdataInitial extends GetstreakdataState {}

final class GetstreakdataLoading extends GetstreakdataState {}

final class GetstreakdataComplete extends GetstreakdataState {
  final List<int> streakdata;
  const GetstreakdataComplete({required this.streakdata});
}

final class GetstreakdataError extends GetstreakdataState {
  final Failures failures;
  const GetstreakdataError({required this.failures});
}
