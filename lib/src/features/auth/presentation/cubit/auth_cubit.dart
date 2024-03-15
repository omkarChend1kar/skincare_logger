import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/common/services/service_locator.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/core/utill/usecase/usecase.dart';
import 'package:skincare_logger/src/features/auth/domain/usecases/create_account_usecase.dart'
    as create_account_usecase;
import 'package:skincare_logger/src/features/auth/domain/usecases/get_loginstatus_usecase.dart';
import 'package:skincare_logger/src/features/auth/domain/usecases/signin_usecase.dart'
    as signin_usecase;
import 'package:skincare_logger/src/features/auth/domain/usecases/signout_usecase.dart'
    as signout_usecase;

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final GetLoginStatusUsecase getLoginStatusUsecase;
  final create_account_usecase.CreatAccountUsecase createAccountUsecase;
  final signin_usecase.SigninUserUsecase signinUserUsecase;
  final signout_usecase.SignOutUserUsecase signOutUserUsecase;
  AuthCubit(
    this.getLoginStatusUsecase,
    this.createAccountUsecase,
    this.signinUserUsecase,
    this.signOutUserUsecase,
  ) : super(AuthInitial());

  Future<void> checkSignInStatus() async {
    emit(AuthLoading());
    final result = await getLoginStatusUsecase(NoParams());
    if (result == null) {
      emit(
        const AuthError(
          failures: ServerFailure(
            message: "Something went wrong",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(AuthError(failures: l)),
        (r) => r.listen(
          (event) {
            if (event) {
              emit(AuthSignedIn());
            } else {
              emit(AuthSignedOut());
            }
          },
        ),
      );
    }
  }

  Future<void> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await createAccountUsecase(
      create_account_usecase.Params(
        email: email,
        password: password,
        name: name,
      ),
    );
    if (result == null) {
      emit(
        const AuthError(
          failures: ServerFailure(
            message: "Something went wrong",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(AuthError(failures: l)),
        (r) => emit(AuthSignedIn()),
      );
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await signinUserUsecase(
      signin_usecase.Params(
        email: email,
        password: password,
      ),
    );
    if (result == null) {
      emit(
        const AuthError(
          failures: ServerFailure(
            message: "Something went wrong",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(AuthError(failures: l)),
        (r) => emit(AuthSignedIn()),
      );
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    final result = await signOutUserUsecase(
      NoParams(),
    );
    if (result == null) {
      emit(
        const AuthError(
          failures: ServerFailure(
            message: "Something went wrong",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(AuthError(failures: l)),
        (r) => emit(AuthSignedIn()),
      );
    }
  }
}
