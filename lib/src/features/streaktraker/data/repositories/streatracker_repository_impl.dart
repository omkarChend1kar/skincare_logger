import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/utill/error/exceptions.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/core/utill/network/network_info.dart';
import 'package:skincare_logger/src/features/streaktraker/data/datasources/streak_remote_datasource.dart';
import 'package:skincare_logger/src/features/streaktraker/domain/repositories/streak_data_repository.dart';

@Singleton(as: StreakTrackerRepository)
class StreakTrackerRepositoryImpl extends StreakTrackerRepository {
  final StreakRemoteDatasource streakRemoteDatasource;
  final NetworkInfo networkInfo;

  StreakTrackerRepositoryImpl(
      {required this.streakRemoteDatasource, required this.networkInfo});
  @override
  Future<Either<Failures, List<int>?>> getStreakData(
      {required int noOfDays}) async {
    final isNetworkAvailable = await networkInfo.isConnected;
    if (isNetworkAvailable == null || !isNetworkAvailable) {
      return const Left(
        ServerFailure(message: "No internet connection!"),
      );
    } else {
      try {
        return Right(
          await streakRemoteDatasource.getStreakData(noOfDays: noOfDays),
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
