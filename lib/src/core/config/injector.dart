import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:get_it/get_it.dart';
import 'package:ecommerce_test/src/core/services/hive_service.dart';
import 'package:ecommerce_test/src/data/local/app_database.dart';

import '../../data/remote/dio_api_service.dart';
import '../../presentation/view_model/blocs/assistance/my_bloc_observer.dart';
import '../services/dio_service.dart';
import '../services/setting_service.dart';
import '../services/storage_service.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  injector.registerSingleton<DioService>(DioService());
  await injector<DioService>().initializeService();

  injector.registerSingleton<HiveService>(HiveService());
  await injector<HiveService>().initializeService();

  injector.registerSingleton<DioApiService>(DioApiService(dio: injector<DioService>().dio));

  injector.registerSingleton<AppDatabase>(AppDatabase());

  injector.registerSingleton<StorageService>(StorageService()..initializeService());

  injector.registerSingleton<SettingService>(SettingService());
  await injector<SettingService>().initializeService();

  Bloc.observer = MyBlocObserver();
}
