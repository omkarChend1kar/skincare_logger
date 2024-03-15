import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/core/utill/usecase/usecase.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/entities/skin_routine_entity.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/repositories/routinelogger_repository.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/usecases/routineloggerusecase.dart';

abstract class LogSkincareRoutineUsecase extends RoutineLoggerUsecase
    implements UseCase<void, Params> {}

class Params extends Equatable {
  final SkinCareRoutine skinCareRoutine;
  const Params({required this.skinCareRoutine});
  @override
  List<Object?> get props => [skinCareRoutine];
}

@Singleton(as: LogSkincareRoutineUsecase)
class LogSkincareRoutineUsecaseImpl extends LogSkincareRoutineUsecase {
  final RoutineLoggerRepository routineLoggerRepository;
  LogSkincareRoutineUsecaseImpl({
    required this.routineLoggerRepository,
  });
  @override
  Future<Either<Failures, void>>? call(Params params) {
    return routineLoggerRepository.logSkinCareRoutine(
      skinCareRoutine: params.skinCareRoutine,
    );
  }
}
