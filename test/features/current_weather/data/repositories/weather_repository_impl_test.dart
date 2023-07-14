import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weatheriran/core/network/network_info.dart';
import 'package:weatheriran/features/current_weather/data/datasources/weather_local_data_source.dart';
import 'package:weatheriran/features/current_weather/data/datasources/weather_remote_data_source.dart';
import 'package:weatheriran/features/current_weather/data/repositories/weather_repository_impl.dart';
import 'package:weatheriran/core/error/exception.dart';
import 'package:weatheriran/core/error/failure.dart';
import 'package:weatheriran/core/network/network_info.dart';
import 'package:weatheriran/features/current_weather/data/datasources/weather_local_data_source.dart';
import 'package:weatheriran/features/current_weather/data/datasources/weather_remote_data_source.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';
import 'package:weatheriran/features/current_weather/data/repositories/weather_repository_impl.dart';

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([
  WeatherRepositoryImpl,
  WeatherLocalDataSource,
  WeatherRemoteDataSource,
  NetworkInfo
])
void main() {
  late WeatherRepositoryImpl repositoryImpl;
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late MockWeatherLocalDataSource mockWeatherLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    mockWeatherLocalDataSource = MockWeatherLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = WeatherRepositoryImpl(
        remoteDataSource: mockWeatherRemoteDataSource,
        localDataSource: mockWeatherLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      // This setUp applies only to the 'device is online' group
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      // This setUp applies only to the 'device is online' group
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('get current weather', () {
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these three variables throughout all the tests
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

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockWeatherRemoteDataSource.getWeather())
          .thenAnswer((_) async => tCurrentWeatherModel);
      // act
      await repositoryImpl.getCurrentWeather();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      // This setUp applies only to the 'device is online' group
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockWeatherRemoteDataSource.getWeather())
              .thenAnswer((_) async => tCurrentWeatherModel);
          // act
          final result = await repositoryImpl.getCurrentWeather();
          // assert
          verify(mockWeatherRemoteDataSource.getWeather());
          expect(result, equals(const Right(tCurrentWeatherModel)));
        },
      );
      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          /// uncomment when run test without run test group
          /// when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockWeatherRemoteDataSource.getWeather())
              .thenAnswer((_) async => tCurrentWeatherModel);
          // act
          await repositoryImpl.getCurrentWeather();
          // assert
          verify(mockWeatherRemoteDataSource.getWeather());
          verify(mockWeatherLocalDataSource.cacheWeather(tCurrentWeatherModel));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockWeatherRemoteDataSource.getWeather())
              .thenThrow(ServerException());
          // act
          final result = await repositoryImpl.getCurrentWeather();
          // assert
          verify(mockWeatherRemoteDataSource.getWeather());
          verifyZeroInteractions(mockWeatherLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestOffline(() {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return last locally cache data when the data is present',
          () async {
        // arrange
        when(mockWeatherLocalDataSource.getLastWeather())
            .thenAnswer((_) async => tCurrentWeatherModel);
        //act
        final result = await repositoryImpl.getCurrentWeather();
        //assert
        verifyZeroInteractions(mockWeatherRemoteDataSource);
        verify(mockWeatherLocalDataSource.getLastWeather());
        expect(result, const Right(tCurrentWeatherModel));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        // arrange
        when(mockWeatherLocalDataSource.getLastWeather())
            .thenThrow(CacheException());
        //act
        final result = await repositoryImpl.getCurrentWeather();
        //assert
        verifyZeroInteractions(mockWeatherRemoteDataSource);
        verify(mockWeatherLocalDataSource.getLastWeather());
        expect(result, Left(CacheFailure()));
      });
    });
  });
}
