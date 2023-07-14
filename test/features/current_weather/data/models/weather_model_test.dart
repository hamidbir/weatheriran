import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weatheriran/core/fixture/fixture_reader.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';
import 'package:weatheriran/features/current_weather/domain/entities/sys.dart';
import 'package:weatheriran/features/current_weather/domain/entities/weather.dart';

void main() {
  const tWeatherModel = [
    WeatherModel(
        id: 803, main: 'Clouds', description: 'broken clouds', icon: '04d')
  ];

  group('from json', () {
    test('should return a valid model when the JSON Weather is a Weather model',
        () async {
      //arrenge
      final jsonMap = json.decode(fixture('weatherr.json')) as List;
      //act
      final result = jsonMap
          .map((wJson) => WeatherModel.fromJson(wJson))
          .toList(); //MainWeatherModel.fromJson(jsonMap[0]);
      //assert
      expect(result, tWeatherModel);
    });
  });
  test('should be a subclass of current Weather entity', () async {
    expect(tWeatherModel[0], isA<Weather>());
  });
  group('to Json', () {
    test('should return a Json map contaning the proper data', () async {
      //act
      List result = tWeatherModel.map((player) => player.toJson()).toList();
      //asset
      final exceptedJson = [
        {
          "id": 803,
          "main": "Clouds",
          "description": "broken clouds",
          "icon": "04d"
        }
      ];
      expect(result, exceptedJson);
    });
  });
}
