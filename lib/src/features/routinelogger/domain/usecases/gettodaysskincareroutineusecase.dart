import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/core/utill/usecase/usecase.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/entities/skin_routine_entity.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/repositories/routinelogger_repository.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/usecases/routineloggerusecase.dart';

abstract class GetTodaysSkincareRoutineUsecase extends RoutineLoggerUsecase
    implements UseCase<Stream<List<SkinCareRoutine>>, NoParams> {}

@Singleton(as: GetTodaysSkincareRoutineUsecase)
class GetTodaysSkincareRoutineUsecaseImpl
    extends GetTodaysSkincareRoutineUsecase {
  final RoutineLoggerRepository routineLoggerRepository;
  GetTodaysSkincareRoutineUsecaseImpl({
    required this.routineLoggerRepository,
  });
  @override
  Future<Either<Failures, Stream<List<SkinCareRoutine>>>>? call(
      NoParams params) {
    return routineLoggerRepository.getTodaySkinsCareRoutine();
  }
}
