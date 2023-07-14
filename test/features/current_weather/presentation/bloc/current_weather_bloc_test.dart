import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weatheriran/core/error/failure.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';
import 'package:weatheriran/features/current_weather/domain/usecases/get_current_weather.dart';
import 'package:weatheriran/features/current_weather/presentation/bloc/current_weather_bloc.dart';

import 'current_weather_bloc_test.mocks.dart';

@GenerateMocks([GetCurrentWeather])
void main() {
  late CurrentWeatherBloc bloc;
  late MockGetCurrentWeather mockGetCurrentWeather;
  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    bloc = CurrentWeatherBloc(getWeather: mockGetCurrentWeather);
  });

  test('initialState should be Empty', () {
    //assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetCurrentWeather', () {
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

    test('should get data from the Weather use case', () async* {
      //arrange
      when(mockGetCurrentWeather(any))
          .thenAnswer((_) async => const Right(tCurrentWeatherModel));
      //act
      bloc.add(UpdatingWeather());
      await untilCalled(mockGetCurrentWeather(any));
      //assert
      verify(mockGetCurrentWeather);
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async* {
      //arrange
      when(mockGetCurrentWeather(any))
          .thenAnswer((_) async => const Right(tCurrentWeatherModel));
      //assert later
      final expected = [Empty(), Loading(), const Loaded(tCurrentWeatherModel)];
      expectLater(bloc.state, emitsInOrder(expected));
      //assert
      bloc.add(UpdatingWeather());
    });

    test('should emit [Loading, Error] when getting data fails', () async* {
      //arrange
      when(mockGetCurrentWeather(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        const Error(SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //assert
      bloc.add(UpdatingWeather());
    });

    test(
        'should emit [Loading, Error] when a proper message for the error when getting data fails',
        () async* {
      //arrange
      when(mockGetCurrentWeather(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [Empty(), Loading(), const Error(CACHE_FAILURE_MESSAGE)];
      expectLater(bloc.state, emitsInOrder(expected));
      //assert
      bloc.add(UpdatingWeather());
    });
  });
}
