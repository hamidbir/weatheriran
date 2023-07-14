import 'package:weatheriran/core/error/exception.dart';
import 'package:weatheriran/core/network/network_info.dart';
import 'package:weatheriran/core/usecases/usecase.dart';
import 'package:weatheriran/features/current_weather/data/datasources/weather_local_data_source.dart';
import 'package:weatheriran/features/current_weather/data/datasources/weather_remote_data_source.dart';
import 'package:weatheriran/features/current_weather/domain/entities/current_weather.dart';
import 'package:weatheriran/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weatheriran/features/current_weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, CurrentWeather>> getCurrentWeather() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getWeather();
        localDataSource.cacheWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localWeather = await localDataSource.getLastWeather();
        return Right(localWeather);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, CurrentWeather>> getCurrentWeatherWithGeo(
      CityParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getWeatherWithGeo(params);
        localDataSource.cacheWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localWeather = await localDataSource.getLastWeather();
        return Right(localWeather);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
