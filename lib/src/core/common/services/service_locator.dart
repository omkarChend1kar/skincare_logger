import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/common/services/service_locator.config.dart';

final sl = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async => await sl.init();
