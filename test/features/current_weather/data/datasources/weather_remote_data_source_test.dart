import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weatheriran/core/error/exception.dart';
import 'package:weatheriran/core/fixture/fixture_reader.dart';
import 'package:weatheriran/features/current_weather/data/datasources/weather_remote_data_source.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';

import 'weather_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late WeatherRemoteDataSourceImpl dataSourceImpl;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSourceImpl = WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('weather.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getWeather', () {
    final tWeatherModel =
        CurrentWeatherModel.fromJson(json.decode(fixture('weather.json')));
    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      dataSourceImpl.getWeather();
      //assert
      verify(mockHttpClient.get(
          Uri.parse(
              "https://api.openweathermap.org/data/2.5/weather?lat=32.83961&lon=59.2177294&appid=e9c9866d36637dbc23dbff654e160d61"),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return NumberTrivia when the rsponse code is 200(success',
        () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      final result = await dataSourceImpl.getWeather();
      //assert
      expect(result, equals(tWeatherModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setUpMockHttpClientFailure404();
      //act
      final call = dataSourceImpl.getWeather();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
