import 'package:dartz/dartz.dart';
import 'package:weatheriran/core/usecases/usecase.dart';
import 'package:weatheriran/features/current_weather/domain/entities/current_weather.dart';

import '../../../../core/error/failure.dart';

abstract class WeatherRepository {
  Future<Either<Failure, CurrentWeather>> getCurrentWeather();
  Future<Either<Failure, CurrentWeather>> getCurrentWeatherWithGeo(
      CityParams params);
}
