import 'package:face_camera/face_camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skincare_logger/firebase_options.dart';
import 'package:skincare_logger/src/core/common/localization/cubit/set_lang_cubit.dart';
import 'package:skincare_logger/src/core/utill/router/router.dart';
import 'package:skincare_logger/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:skincare_logger/src/features/routinelogger/presentation/cubit/routinelogger_cubit.dart';
import 'package:skincare_logger/src/features/routinelogger/presentation/logskincarecubit/logskincare_cubit.dart';
import 'package:skincare_logger/src/features/streaktraker/presentation/cubit/getstreakdata_cubit.dart';

import 'src/core/common/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureDependencies();
  FaceCamera.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthCubit>()..checkSignInStatus(),
        ),
        BlocProvider(
          create: (context) =>
              sl<RoutineloggerCubit>()..getTodaysSkincareRoutine(),
        ),
        BlocProvider(
          create: (context) => sl<LogskincareCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<GetstreakdataCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        onGenerateRoute: AppRouter.generateRoute,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
