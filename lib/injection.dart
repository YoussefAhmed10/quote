import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:qoutes/core/api/api_consumer.dart';
import 'package:qoutes/core/api/app_interceptor.dart';
import 'package:qoutes/core/api/dio_consumer.dart';
import 'package:qoutes/core/network/netwok_info.dart';
import 'package:qoutes/features/random_qoute/data/datasources/random_qoute_local_datasource.dart';
import 'package:qoutes/features/random_qoute/data/repositories/qoute_repo_imple.dart';
import 'package:qoutes/features/random_qoute/domain/repositories/qoute_repo.dart';
import 'package:qoutes/features/random_qoute/domain/usecases/get_random_qoute.dart';
import 'package:qoutes/features/random_qoute/presentation/cubit/random_qoute_cubit.dart';
import 'package:qoutes/features/splash/data/datasources/lang_local_datasource.dart';
import 'package:qoutes/features/splash/data/repositories/lange_repo_impl.dart';
import 'package:qoutes/features/splash/domain/repositories/lang_repo.dart';
import 'package:qoutes/features/splash/domain/usecases/change_locale.dart';
import 'package:qoutes/features/splash/domain/usecases/get_save_lang.dart';
import 'package:qoutes/features/splash/presentation/cubit/local_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/random_qoute/data/datasources/random_qoute_from_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!Feature

  //Blocs

  sl.registerFactory(() => RandomQouteCubit(getRandomQouteUseCase: sl()));
  sl.registerFactory(
      () => LocaleCubit(getSavedLangUseCase: sl(), changeLocale: sl()));

  //UseCase

  sl.registerLazySingleton<GetRandomQoute>(
      () => GetRandomQoute(qouteRepo: sl()));
  sl.registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(langRepo: sl()));
  sl.registerLazySingleton<ChangeLocaleUseCase>(
      () => ChangeLocaleUseCase(langRepo: sl()));

  //Repos
  sl.registerLazySingleton<QouteRepo>(() => QouteRepoImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<LangRepo>(() => LangRepoImpl(
        langLocalDataSource: sl(),
      ));

  //DataSource
  sl.registerLazySingleton<RandomQouteFromLocalDataSource>(
      () => RadnomQouteLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RandomQouteFromRemoteDataSource>(
      () => RandomQouteFromRemoteDataSourcelmp(apiConsumer: sl()));
  sl.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(sharedPreferences: sl()));

  //!core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(clint: sl()));

  //!External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
