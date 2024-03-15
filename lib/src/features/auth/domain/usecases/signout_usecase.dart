import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/core/utill/usecase/usecase.dart';
import 'package:skincare_logger/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:skincare_logger/src/features/auth/domain/usecases/auth_usecase.dart';

abstract class SignOutUserUsecase extends AuthenticationUsecase
    implements UseCase<void, NoParams> {}

@Singleton(as: SignOutUserUsecase)
class SignOutUserUsecaseImpl extends SignOutUserUsecase {
  final AuthRepository authenticationRepository;
  SignOutUserUsecaseImpl({
    required this.authenticationRepository,
  });
  @override
  Future<Either<Failures, void>>? call(NoParams params) {
    return authenticationRepository.signOut();
  }
}
