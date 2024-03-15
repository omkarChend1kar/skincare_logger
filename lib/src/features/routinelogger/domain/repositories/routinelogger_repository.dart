import 'package:dartz/dartz.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/entities/skin_routine_entity.dart';

abstract class RoutineLoggerRepository {
  ///
  Future<Either<Failures, void>> logSkinCareRoutine({
   required SkinCareRoutine skinCareRoutine,
  });

  ///
  Future<Either<Failures, Stream<List<SkinCareRoutine>>>>
      getTodaySkinsCareRoutine();
}
