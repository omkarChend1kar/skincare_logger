// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/utill/error/exceptions.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/core/utill/network/network_info.dart';
import 'package:skincare_logger/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:skincare_logger/src/features/auth/domain/repositories/auth_repository.dart';

@Singleton(as: AuthRepository)
class AuthenticationRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authenticationRemoteDatasource;
  final NetworkInfo networkInfo;
  const AuthenticationRepositoryImpl({
    required this.authenticationRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, void>> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    final isNetworkAvailable = await networkInfo.isConnected;
    if (isNetworkAvailable == null || !isNetworkAvailable) {
      return const Left(
        ServerFailure(message: "No internet connection!"),
      );
    } else {
      try {
        return Right(
          await authenticationRemoteDatasource.createAccount(
            name: name,
            email: email,
            password: password,
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

  @override
  Future<Either<Failures, void>> signIn({
    required String email,
    required String password,
  }) async {
    final isNetworkAvailable = await networkInfo.isConnected;
    if (isNetworkAvailable == null || !isNetworkAvailable) {
      return const Left(
        ServerFailure(message: "No internet connection!"),
      );
    } else {
      try {
        return Right(
          await authenticationRemoteDatasource.signIn(
            email: email,
            password: password,
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

  @override
  Future<Either<Failures, void>> signInWithGoogle() async {
    final isNetworkAvailable = await networkInfo.isConnected;
    if (isNetworkAvailable == null || !isNetworkAvailable) {
      return const Left(
        ServerFailure(message: "No internet connection!"),
      );
    } else {
      try {
        return Right(
          await authenticationRemoteDatasource.signInWithGoogle(),
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
  Future<Either<Failures, void>> signOut() async {
    final isNetworkAvailable = await networkInfo.isConnected;
    if (isNetworkAvailable == null || !isNetworkAvailable) {
      return const Left(
        ServerFailure(message: "No internet connection!"),
      );
    } else {
      try {
        return Right(
          await authenticationRemoteDatasource.signOut(),
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
  Future<Either<Failures, Stream<bool>>> getUserLoginStatus() async {
    final isNetworkAvailable = await networkInfo.isConnected;
    if (isNetworkAvailable == null || !isNetworkAvailable) {
      return const Left(
        ServerFailure(message: "No internet connection!"),
      );
    } else {
      try {
        return Right(
          await authenticationRemoteDatasource.getUserLoginStatus(),
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
