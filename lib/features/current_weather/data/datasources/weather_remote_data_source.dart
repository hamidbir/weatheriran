import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:weatheriran/core/error/exception.dart';
import 'package:weatheriran/core/usecases/usecase.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<CurrentWeatherModel> getWeather(
      /*double lat, double lon, String apiKey*/);
  Future<CurrentWeatherModel> getWeatherWithGeo(CityParams params);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<CurrentWeatherModel> getWeather(
      /*double lat, double lon, String apiKey*/) async {
    return _getWeatherFromUrl(
        'https://api.openweathermap.org/data/2.5/weather?lat=32.83961&lon=59.2177294&appid=e9c9866d36637dbc23dbff654e160d61');
  }

  Future<CurrentWeatherModel> _getWeatherFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return CurrentWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CurrentWeatherModel> getWeatherWithGeo(CityParams params) async {
    return _getWeatherFromUrl(
        'https://api.openweathermap.org/data/2.5/weather?lat=${params.lat}&lon=${params.lon}&appid=KEY');
  }
}
