import 'package:dartz/dartz.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';

abstract class StreakTrackerRepository {
  ///
  Future<Either<Failures, List<int>?>> getStreakData({required int noOfDays});
}
