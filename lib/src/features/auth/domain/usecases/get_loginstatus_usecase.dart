import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/core/utill/usecase/usecase.dart';
import 'package:skincare_logger/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:skincare_logger/src/features/auth/domain/usecases/auth_usecase.dart';

abstract class GetLoginStatusUsecase extends AuthenticationUsecase
    implements UseCase<Stream<bool>, NoParams> {}

@Singleton(as: GetLoginStatusUsecase)
class GetLoginStatusUsecaseImpl extends GetLoginStatusUsecase {
  final AuthRepository authenticationRepository;
  GetLoginStatusUsecaseImpl({
    required this.authenticationRepository,
  });
  @override
  Future<Either<Failures, Stream<bool>>>? call(NoParams params) {
    return authenticationRepository.getUserLoginStatus();
  }
}
