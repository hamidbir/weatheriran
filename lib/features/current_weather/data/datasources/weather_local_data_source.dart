import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatheriran/core/error/exception.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';

abstract class WeatherLocalDataSource {
  Future<CurrentWeatherModel> getLastWeather();
  Future<void> cacheWeather(CurrentWeatherModel weatherModel);
}

const CACHED_WEATHER = 'CACHED_WEATHER';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheWeather(CurrentWeatherModel weatherModel) {
    return sharedPreferences.setString(
        CACHED_WEATHER, json.encode(weatherModel.toJson()));
  }

  @override
  Future<CurrentWeatherModel> getLastWeather() {
    final jsonString = sharedPreferences.getString(CACHED_WEATHER);
    if (jsonString != null) {
      return Future.value(
          CurrentWeatherModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
