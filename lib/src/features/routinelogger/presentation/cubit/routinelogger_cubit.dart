import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/core/utill/usecase/usecase.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/entities/skin_routine_entity.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/usecases/gettodaysskincareroutineusecase.dart';

part 'routinelogger_state.dart';

@injectable
class RoutineloggerCubit extends Cubit<RoutineloggerState> {
  final GetTodaysSkincareRoutineUsecase getTodaysSkincareRoutineUsecase;
  RoutineloggerCubit(this.getTodaysSkincareRoutineUsecase)
      : super(RoutineloggerInitial());

  Future<void> getTodaysSkincareRoutine() async {
    emit(RoutineloggerLoading());
    final result = await getTodaysSkincareRoutineUsecase(NoParams());
    if (result == null) {
      emit(
        RoutineloggerError(
          failures: const ServerFailure(
            message: "Something went wrong",
          ),
        ),
      );
    } else {
      result.fold(
        (l) => emit(RoutineloggerError(failures: l)),
        (r) => r.listen(
          (skinCareRoutine) {
            emit(
              RoutineloggerComplete(skinCareRoutine: skinCareRoutine),
            );
          },
        ),
      );
    }
  }
}
