import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatheriran/core/network/network_info.dart';
import 'package:weatheriran/features/current_weather/data/datasources/weather_local_data_source.dart';
import 'package:weatheriran/features/current_weather/data/datasources/weather_remote_data_source.dart';
import 'package:weatheriran/features/current_weather/data/repositories/weather_repository_impl.dart';
import 'package:weatheriran/features/current_weather/domain/repositories/weather_repository.dart';
import 'package:weatheriran/features/current_weather/domain/usecases/get_current_weather.dart';
import 'package:weatheriran/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weatheriran/features/search/data/datasources/search_remote_data_source.dart';
import 'package:weatheriran/features/search/data/repositories/search_repository_impl.dart';
import 'package:weatheriran/features/search/domain/repositories/search_repository.dart';
import 'package:weatheriran/features/search/domain/usecases/get_geo_city.dart';
import 'package:weatheriran/features/search/presentation/bloc/search_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!Features - Weather
  //Bloc
  sl.registerFactory(
      () => CurrentWeatherBloc(getWeather: sl(), getWeatherWithGeo: sl()));
  //Use cases
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));
  sl.registerLazySingleton(() => GetCurrentWeatherWithGeo(sl()));

  //Repository
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  //Data source
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImpl(sharedPreferences: sl()));

  //!Features - Search
  //Bloc
  sl.registerFactory(() => SearchBloc(sl()));
  //Use cases
  sl.registerLazySingleton(() => GetGeoCity(sl()));
  //Repository
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  //Data source
  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(client: sl()));

  //!Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //!External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
