import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/core/utill/usecase/usecase.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/entities/skin_routine_entity.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/repositories/routinelogger_repository.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/usecases/routineloggerusecase.dart';
import 'package:skincare_logger/src/features/streaktraker/domain/repositories/streak_data_repository.dart';

abstract class GetStreakdataUsecase extends RoutineLoggerUsecase
    implements UseCase< List<int>?, Params> {}

class Params extends Equatable {
  final int noOfDays;
  const Params({required this.noOfDays});
  @override
  List<Object?> get props => [noOfDays];
}

@Singleton(as: GetStreakdataUsecase)
class GetStreakdataUsecaseImpl extends GetStreakdataUsecase {
  final StreakTrackerRepository streakTrackerRepository;
  GetStreakdataUsecaseImpl({
    required this.streakTrackerRepository,
  });
  @override
  Future<Either<Failures, List<int>?>> call(Params params) {
    return streakTrackerRepository.getStreakData(
      noOfDays: params.noOfDays,
    );
  }
}
