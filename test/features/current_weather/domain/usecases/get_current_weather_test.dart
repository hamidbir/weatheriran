import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weatheriran/core/usecases/usecase.dart';
import 'package:weatheriran/features/current_weather/domain/entities/clouds.dart';
import 'package:weatheriran/features/current_weather/domain/entities/coord.dart';
import 'package:weatheriran/features/current_weather/domain/entities/current_weather.dart';
import 'package:weatheriran/features/current_weather/domain/entities/main_weather.dart';
import 'package:weatheriran/features/current_weather/domain/entities/sys.dart';
import 'package:weatheriran/features/current_weather/domain/entities/weather.dart';
import 'package:weatheriran/features/current_weather/domain/entities/wind.dart';
import 'package:weatheriran/features/current_weather/domain/repositories/weather_repository.dart';
import 'package:weatheriran/features/current_weather/domain/usecases/get_current_weather.dart';

import 'get_current_weather_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  GetCurrentWeather usecase;
  MockWeatherRepository mockWeatherRepository;
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(mockWeatherRepository);
  });
  const tCoord = Coord(lon: 20, lat: 20);
  const tWeather = [
    Weather(id: 1, main: 'good', description: ' speak good', icon: '090')
  ];
  const tMainWeather = MainWeather(
      temp: 20,
      feelsLike: 20.0,
      tempMin: 10.0,
      tempMax: 25.0,
      pressure: 800,
      humidity: 100);
  const tWind = Wind(speed: 100, deg: 45);
  const tClouds = Clouds(all: 20);
  const tSys =
      Sys(type: 10, id: 20, country: 'IR', sunrise: 053456, sunset: 164569);

  const tCurrentWeahter = CurrentWeather(
      coord: tCoord,
      weather: tWeather,
      base: 'test base',
      main: tMainWeather,
      visibility: 50,
      wind: tWind,
      clouds: tClouds,
      dt: 60,
      sys: tSys,
      timezone: 1230,
      id: 1,
      name: 'Birjand',
      cod: 056);

  test('should get current weather for the weather from the repository',
      () async {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(mockWeatherRepository);
    when(mockWeatherRepository.getCurrentWeather())
        .thenAnswer((realInvocation) async => const Right(tCurrentWeahter));
    final result = await usecase(NoParams());
    expect(result, const Right(tCurrentWeahter));
    verify(mockWeatherRepository.getCurrentWeather());
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
