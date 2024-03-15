import 'package:dartz/dartz.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';

abstract class AuthRepository {
  ///
  Future<Either<Failures, Stream<bool>>> getUserLoginStatus();

  ///
  Future<Either<Failures, void>> createAccount({
    required String name,
    required String email,
    required String password,
  });

  ///
  Future<Either<Failures, void>> signIn({
    required String email,
    required String password,
  });

  ///
  Future<Either<Failures, void>> signInWithGoogle();

  ///
  Future<Either<Failures, void>> signOut();
}
