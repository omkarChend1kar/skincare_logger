import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/utill/error/failures.dart';
import 'package:skincare_logger/src/features/streaktraker/domain/usecases/streaktrackerusecase.dart';

part 'getstreakdata_state.dart';

@injectable
class GetstreakdataCubit extends Cubit<GetstreakdataState> {
  final GetStreakdataUsecase getStreakdataUsecase;
  GetstreakdataCubit(this.getStreakdataUsecase) : super(GetstreakdataInitial());

  Future<void> getstreakdata({required int noOfDays}) async {
    emit(GetstreakdataLoading());
    final result = await getStreakdataUsecase(Params(noOfDays: noOfDays));
    if (result == null) {
      emit(
        const GetstreakdataError(
          failures: ServerFailure(errorDescription: "Something went wrong"),
        ),
      );
    } else {
      result.fold((l) => emit(GetstreakdataError(failures: l)),
          (r) => emit(GetstreakdataComplete(streakdata: r!)));
    }
  }
}
