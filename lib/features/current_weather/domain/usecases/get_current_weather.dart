import 'package:dartz/dartz.dart';
import 'package:weatheriran/core/error/failure.dart';
import 'package:weatheriran/core/usecases/usecase.dart';
import 'package:weatheriran/features/current_weather/domain/entities/current_weather.dart';
import 'package:weatheriran/features/current_weather/domain/repositories/weather_repository.dart';

class GetCurrentWeather extends Usecase<CurrentWeather, NoParams> {
  GetCurrentWeather(this.repository);
  final WeatherRepository repository;
  @override
  Future<Either<Failure, CurrentWeather>> call(NoParams params) async {
    return await repository.getCurrentWeather();
  }
}

class GetCurrentWeatherWithGeo extends Usecase<CurrentWeather, CityParams> {
  final WeatherRepository repository;

  GetCurrentWeatherWithGeo(this.repository);
  @override
  Future<Either<Failure, CurrentWeather>> call(CityParams params) async {
    return await repository.getCurrentWeatherWithGeo(params);
  }
}
