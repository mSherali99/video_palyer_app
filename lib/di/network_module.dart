import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:video_palyer_app/data/source/remote/api/base_api_impl.dart';
import 'package:video_palyer_app/data/source/remote/api/first_api.dart';
import 'package:video_palyer_app/data/source/remote/api/second_api.dart';

final getIt = GetIt.I;

void setUpNetworkApis() {
  getIt.registerLazySingleton(() => Dio(BaseOptions()));
  getIt.registerLazySingleton<FirstApi>(() => BaseApiImpl(getIt.get<Dio>()));
  getIt.registerLazySingleton<SecondApi>(() => BaseApiImpl(getIt.get<Dio>()));
}
