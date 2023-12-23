import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weatheriran/core/fixture/fixture_reader.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';
import 'package:weatheriran/features/current_weather/domain/entities/main_weather.dart';

void main() {
  const tMainWeatherModel = MainWeatherModel(
      temp: 296.35,
      feelsLike: 295.12,
      tempMin: 296.35,
      tempMax: 296.35,
      pressure: 1017,
      humidity: 15);

  group('from json', () {
    test(
        'should return a valid model when the JSON Main Weather is a Main Weather model',
        () async {
      //arrenge
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('main_weather.json'));
      //act
      final result = MainWeatherModel.fromJson(jsonMap);
      //assert
      expect(result, tMainWeatherModel);
    });
  });
  test('should be a subclass of current MainWeather entity', () async {
    expect(tMainWeatherModel, isA<MainWeather>());
  });
  group('to Json', () {
    test('should return a Json map contaning the proper data', () async {
      //act
      final result = tMainWeatherModel.toJson();
      //asset
      final exceptedJson = {
        "temp": 296.35,
        "feels_like": 295.12,
        "temp_min": 296.35,
        "temp_max": 296.35,
        "pressure": 1017,
        "humidity": 15
      };
      expect(result, exceptedJson);
    });
  });
}
