// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i11;
import 'package:skincare_logger/src/core/common/localization/cubit/set_lang_cubit.dart'
    as _i10;
import 'package:skincare_logger/src/core/utill/module/register_module.dart'
    as _i31;
import 'package:skincare_logger/src/core/utill/network/network_info.dart'
    as _i6;
import 'package:skincare_logger/src/core/utill/utills/utills.dart' as _i15;
import 'package:skincare_logger/src/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i16;
import 'package:skincare_logger/src/features/auth/data/repositories/auth_repository_impl.dart'
    as _i18;
import 'package:skincare_logger/src/features/auth/domain/repositories/auth_repository.dart'
    as _i17;
import 'package:skincare_logger/src/features/auth/domain/usecases/create_account_usecase.dart'
    as _i19;
import 'package:skincare_logger/src/features/auth/domain/usecases/get_loginstatus_usecase.dart'
    as _i20;
import 'package:skincare_logger/src/features/auth/domain/usecases/signin_usecase.dart'
    as _i29;
import 'package:skincare_logger/src/features/auth/domain/usecases/signin_with_google_usecase.dart'
    as _i27;
import 'package:skincare_logger/src/features/auth/domain/usecases/signout_usecase.dart'
    as _i28;
import 'package:skincare_logger/src/features/auth/presentation/cubit/auth_cubit.dart'
    as _i30;
import 'package:skincare_logger/src/features/routinelogger/data/datasources/routine_logger_remotedatasource.dart'
    as _i7;
import 'package:skincare_logger/src/features/routinelogger/data/repositories/routine_logger_repositoryimpl.dart'
    as _i9;
import 'package:skincare_logger/src/features/routinelogger/domain/repositories/routinelogger_repository.dart'
    as _i8;
import 'package:skincare_logger/src/features/routinelogger/domain/usecases/gettodaysskincareroutineusecase.dart'
    as _i22;
import 'package:skincare_logger/src/features/routinelogger/domain/usecases/logskincareroutineusecase.dart'
    as _i24;
import 'package:skincare_logger/src/features/routinelogger/presentation/cubit/routinelogger_cubit.dart'
    as _i26;
import 'package:skincare_logger/src/features/routinelogger/presentation/logskincarecubit/logskincare_cubit.dart'
    as _i25;
import 'package:skincare_logger/src/features/streaktraker/data/datasources/streak_remote_datasource.dart'
    as _i12;
import 'package:skincare_logger/src/features/streaktraker/data/repositories/streatracker_repository_impl.dart'
    as _i14;
import 'package:skincare_logger/src/features/streaktraker/domain/repositories/streak_data_repository.dart'
    as _i13;
import 'package:skincare_logger/src/features/streaktraker/domain/usecases/streaktrackerusecase.dart'
    as _i21;
import 'package:skincare_logger/src/features/streaktraker/presentation/cubit/getstreakdata_cubit.dart'
    as _i23;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.FirebaseAuth>(() => registerModule.auth);
    gh.factory<_i4.FirebaseFirestore>(() => registerModule.db);
    gh.factory<_i5.InternetConnectionChecker>(
        () => registerModule.internetConnectionChecker);
    gh.singleton<_i6.NetworkInfo>(() => _i6.NetworkInfoImpl(
        connectionChecker: gh<_i5.InternetConnectionChecker>()));
    gh.singleton<_i7.RoutineLoggerRemoteDatasource>(
        () => _i7.RoutineLoggerRemoteDatasourceImpl(
              db: gh<_i4.FirebaseFirestore>(),
              auth: gh<_i3.FirebaseAuth>(),
            ));
    gh.singleton<_i8.RoutineLoggerRepository>(
        () => _i9.RoutineLoggerRepositoryImpl(
              routineLoggerRemoteDatasource:
                  gh<_i7.RoutineLoggerRemoteDatasource>(),
              networkInfo: gh<_i6.NetworkInfo>(),
            ));
    gh.factory<_i10.SetLangCubit>(() => _i10.SetLangCubit());
    await gh.factoryAsync<_i11.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i12.StreakRemoteDatasource>(
        () => _i12.StreakRemoteDatasourceImpl(
              db: gh<_i4.FirebaseFirestore>(),
              auth: gh<_i3.FirebaseAuth>(),
            ));
    gh.singleton<_i13.StreakTrackerRepository>(
        () => _i14.StreakTrackerRepositoryImpl(
              streakRemoteDatasource: gh<_i12.StreakRemoteDatasource>(),
              networkInfo: gh<_i6.NetworkInfo>(),
            ));
    gh.singleton<_i15.Utills>(() => _i15.Utills(
          sf: gh<_i11.SharedPreferences>(),
          auth: gh<_i3.FirebaseAuth>(),
        ));
    gh.singleton<_i16.AuthRemoteDatasource>(() => _i16.AuthRemoteDatasourceImpl(
          auth: gh<_i3.FirebaseAuth>(),
          db: gh<_i4.FirebaseFirestore>(),
        ));
    gh.singleton<_i17.AuthRepository>(() => _i18.AuthenticationRepositoryImpl(
          authenticationRemoteDatasource: gh<_i16.AuthRemoteDatasource>(),
          networkInfo: gh<_i6.NetworkInfo>(),
        ));
    gh.singleton<_i19.CreatAccountUsecase>(() => _i19.CreatAccountUsecaseImpl(
        authenticationRepository: gh<_i17.AuthRepository>()));
    gh.singleton<_i20.GetLoginStatusUsecase>(() =>
        _i20.GetLoginStatusUsecaseImpl(
            authenticationRepository: gh<_i17.AuthRepository>()));
    gh.singleton<_i21.GetStreakdataUsecase>(() => _i21.GetStreakdataUsecaseImpl(
        streakTrackerRepository: gh<_i13.StreakTrackerRepository>()));
    gh.singleton<_i22.GetTodaysSkincareRoutineUsecase>(() =>
        _i22.GetTodaysSkincareRoutineUsecaseImpl(
            routineLoggerRepository: gh<_i8.RoutineLoggerRepository>()));
    gh.factory<_i23.GetstreakdataCubit>(
        () => _i23.GetstreakdataCubit(gh<_i21.GetStreakdataUsecase>()));
    gh.singleton<_i24.LogSkincareRoutineUsecase>(() =>
        _i24.LogSkincareRoutineUsecaseImpl(
            routineLoggerRepository: gh<_i8.RoutineLoggerRepository>()));
    gh.factory<_i25.LogskincareCubit>(
        () => _i25.LogskincareCubit(gh<_i24.LogSkincareRoutineUsecase>()));
    gh.factory<_i26.RoutineloggerCubit>(() =>
        _i26.RoutineloggerCubit(gh<_i22.GetTodaysSkincareRoutineUsecase>()));
    gh.singleton<_i27.SignInWithGoogleUserUsecase>(() =>
        _i27.SignInWithGoogleUserUsecaseImpl(
            authenticationRepository: gh<_i17.AuthRepository>()));
    gh.singleton<_i28.SignOutUserUsecase>(() => _i28.SignOutUserUsecaseImpl(
        authenticationRepository: gh<_i17.AuthRepository>()));
    gh.singleton<_i29.SigninUserUsecase>(() => _i29.SigninUserUsecaseImpl(
        authenticationRepository: gh<_i17.AuthRepository>()));
    gh.factory<_i30.AuthCubit>(() => _i30.AuthCubit(
          gh<_i20.GetLoginStatusUsecase>(),
          gh<_i19.CreatAccountUsecase>(),
          gh<_i29.SigninUserUsecase>(),
          gh<_i28.SignOutUserUsecase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i31.RegisterModule {}
