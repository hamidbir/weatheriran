import 'package:flutter_test/flutter_test.dart';
import 'package:weatheriran/core/fixture/fixture_reader.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';
import 'dart:convert';

void main() {
  const tCoordModel = CoordModel(lon: 59.2177, lat: 32.8634);
  const tWeatherModel = [
    WeatherModel(
        id: 803, main: 'Clouds', description: 'broken clouds', icon: '04d')
  ];
  const tMainWeatherModel = MainWeatherModel(
      temp: 296.35,
      feelsLike: 295.12,
      tempMin: 296.35,
      tempMax: 296.35,
      pressure: 1017,
      humidity: 15);
  const tWindModel = WindModel(speed: 15.95, deg: 220);
  const tCloudsModel = CloudsModel(all: 75);
  const tSysModel = SysModel(
      type: 1,
      id: 7481,
      country: 'IR',
      sunrise: 1680831836,
      sunset: 1680877589);

  const tCurrentWeatherModel = CurrentWeatherModel(
      coord: tCoordModel,
      weather: tWeatherModel,
      base: 'stations',
      main: tMainWeatherModel,
      visibility: 800,
      wind: tWindModel,
      clouds: tCloudsModel,
      dt: 1680865437,
      sys: tSysModel,
      timezone: 12600,
      id: 140463,
      name: 'Birjand',
      cod: 200);
  group('from json', () {
    test('should return a valid model when the JSON weather is a Weather model',
        () async {
      //arrenge
      final Map<String, dynamic> jsonMap = json.decode(fixture('weather.json'));
      //act
      final result = CurrentWeatherModel.fromJson(jsonMap);

      //assert
      expect(result, tCurrentWeatherModel);
    });
  });
  group('to Json', () {
    test('should return a Json map contaning the proper data', () async {
      //act
      final result = tCurrentWeatherModel.toJson();
      //asset
      final exceptedJson = {
        "coord": {"lon": 59.2177, "lat": 32.8634},
        "weather": [
          {
            "id": 803,
            "main": "Clouds",
            "description": "broken clouds",
            "icon": "04d"
          }
        ],
        "base": "stations",
        "main": {
          "temp": 296.35,
          "feels_like": 295.12,
          "temp_min": 296.35,
          "temp_max": 296.35,
          "pressure": 1017,
          "humidity": 15
        },
        "visibility": 800,
        "wind": {"speed": 15.95, "deg": 220},
        "clouds": {"all": 75},
        "dt": 1680865437,
        "sys": {
          "type": 1,
          "id": 7481,
          "country": "IR",
          "sunrise": 1680831836,
          "sunset": 1680877589
        },
        "timezone": 12600,
        "id": 140463,
        "name": "Birjand",
        "cod": 200
      };
      expect(result, exceptedJson);
    });
  });
  // test('should be a subclass of current weather entity', () async {
  //   expect(tCurrentWeatherModel, isA<CurrentWeather>());
  // });
}
