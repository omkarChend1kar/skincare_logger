import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/entities/skin_routine_entity.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/usecases/logskincareroutineusecase.dart';

part 'logskincare_state.dart';

@injectable
class LogskincareCubit extends Cubit<LogskincareState> {
  final LogSkincareRoutineUsecase logSkincareRoutineUsecase;
  LogskincareCubit(this.logSkincareRoutineUsecase)
      : super(LogskincareInitial());

  Future<void> logSkinCareRoutine({
    required SkinCareRoutine skinCareRoutine,
  }) async {
    emit(LogskincareLoading());
    final result = await logSkincareRoutineUsecase(
        Params(skinCareRoutine: skinCareRoutine));

    if (result == null) {
      emit(
        const LogskincareError(
          failures: ServerFailure(message: "Something went wrong"),
        ),
      );
    } else {
      result.fold((l) => emit(LogskincareError(failures: l)), (r) => emit(LogskincareComplete()));
    }
  }
}
