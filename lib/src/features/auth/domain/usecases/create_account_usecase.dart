import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/core/utill/usecase/usecase.dart';
import 'package:skincare_logger/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:skincare_logger/src/features/auth/domain/usecases/auth_usecase.dart';

abstract class CreatAccountUsecase extends AuthenticationUsecase
    implements UseCase<void, Params> {}

class Params extends Equatable {
  final String name;
  final String email;
  final String password;
  const Params({
    required this.name,
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [
        name,
        email,
        password,
      ];
}

@Singleton(as: CreatAccountUsecase)
class CreatAccountUsecaseImpl extends CreatAccountUsecase {
  final AuthRepository authenticationRepository;
  CreatAccountUsecaseImpl({
    required this.authenticationRepository,
  });
  @override
  Future<Either<Failures, void>>? call(Params params) {
    return authenticationRepository.createAccount(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}
