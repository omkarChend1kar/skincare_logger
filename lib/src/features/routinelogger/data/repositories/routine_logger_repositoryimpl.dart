import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/utill/error/exceptions.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/core/utill/network/network_info.dart';
import 'package:skincare_logger/src/features/routinelogger/data/datasources/routine_logger_remotedatasource.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/entities/skin_routine_entity.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/repositories/routinelogger_repository.dart';

@Singleton(as: RoutineLoggerRepository)
class RoutineLoggerRepositoryImpl extends RoutineLoggerRepository {
  final RoutineLoggerRemoteDatasource routineLoggerRemoteDatasource;
  final NetworkInfo networkInfo;

  RoutineLoggerRepositoryImpl({
    required this.routineLoggerRemoteDatasource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failures, Stream<List<SkinCareRoutine>>>>
      getTodaySkinsCareRoutine() async {
    final isNetworkAvailable = await networkInfo.isConnected;
    if (isNetworkAvailable == null || !isNetworkAvailable) {
      return const Left(
        ServerFailure(message: "No internet connection!"),
      );
    } else {
      try {
        return Right(
          await routineLoggerRemoteDatasource.getTodaySkinsCareRoutine(),
        );
      } on ServerException catch (error) {
        return Left(
          ServerFailure(
            errorCode: error.errorCode,
            message: error.errorDescription,
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failures, void>> logSkinCareRoutine({
    required SkinCareRoutine skinCareRoutine,
  }) async {
    final isNetworkAvailable = await networkInfo.isConnected;
    if (isNetworkAvailable == null || !isNetworkAvailable) {
      return const Left(
        ServerFailure(message: "No internet connection!"),
      );
    } else {
      try {
        return Right(
          await routineLoggerRemoteDatasource.logSkinCareRoutine(
            skinCareRoutine: skinCareRoutine,
          ),
        );
      } on ServerException catch (error) {
        return Left(
          ServerFailure(
            errorCode: error.errorCode,
            message: error.errorDescription,
          ),
        );
      }
    }
  }
}
