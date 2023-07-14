import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatheriran/core/error/exception.dart';
import 'package:weatheriran/core/fixture/fixture_reader.dart';
import 'package:weatheriran/features/current_weather/data/datasources/weather_local_data_source.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';

import 'weather_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late WeatherLocalDataSourceImpl localDataSource;
  late MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource =
        WeatherLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  group('get LastWeather', () {
    final tWeatherModel =
        CurrentWeatherModel.fromJson(json.decode(fixture('weather.json')));
    test(
        'should return weather from shared preferences when there is one in the cache',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('weather.json'));
      //act
      final result = await localDataSource.getLastWeather();

      //assert
      verify(mockSharedPreferences.getString('CACHED_WEATHER'));
      expect(result, equals(tWeatherModel));
    });

    test('should throw a cache exception when there is not a cached value', () {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = localDataSource.getLastWeather;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });
  group('Cahche Weather', () {
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
    test('should call Shared prefernces to cache the data', () {
      //arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      //act
      localDataSource.cacheWeather(tCurrentWeatherModel);
      // print(result);
      //assert
      final expectedjsonString = json.encode(tCurrentWeatherModel.toJson());
      verify(
          mockSharedPreferences.setString(CACHED_WEATHER, expectedjsonString));
    });
  });
}
