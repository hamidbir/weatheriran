// Mocks generated by Mockito 5.4.0 from annotations
// in weatheriran/test/features/current_weather/data/repositories/weather_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;

import 'package:dartz/dartz.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:weatheriran/core/error/failure.dart' as _i9;
import 'package:weatheriran/core/network/network_info.dart' as _i4;
import 'package:weatheriran/features/current_weather/data/datasources/weather_local_data_source.dart'
    as _i3;
import 'package:weatheriran/features/current_weather/data/datasources/weather_remote_data_source.dart'
    as _i2;
import 'package:weatheriran/features/current_weather/data/models/models.dart'
    as _i6;
import 'package:weatheriran/features/current_weather/data/repositories/weather_repository_impl.dart'
    as _i7;
import 'package:weatheriran/features/current_weather/domain/entities/current_weather.dart'
    as _i10;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWeatherRemoteDataSource_0 extends _i1.SmartFake
    implements _i2.WeatherRemoteDataSource {
  _FakeWeatherRemoteDataSource_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWeatherLocalDataSource_1 extends _i1.SmartFake
    implements _i3.WeatherLocalDataSource {
  _FakeWeatherLocalDataSource_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNetworkInfo_2 extends _i1.SmartFake implements _i4.NetworkInfo {
  _FakeNetworkInfo_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_3<L, R> extends _i1.SmartFake implements _i5.Either<L, R> {
  _FakeEither_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCurrentWeatherModel_4 extends _i1.SmartFake
    implements _i6.CurrentWeatherModel {
  _FakeCurrentWeatherModel_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WeatherRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRepositoryImpl extends _i1.Mock
    implements _i7.WeatherRepositoryImpl {
  MockWeatherRepositoryImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WeatherRemoteDataSource get remoteDataSource => (super.noSuchMethod(
        Invocation.getter(#remoteDataSource),
        returnValue: _FakeWeatherRemoteDataSource_0(
          this,
          Invocation.getter(#remoteDataSource),
        ),
      ) as _i2.WeatherRemoteDataSource);
  @override
  _i3.WeatherLocalDataSource get localDataSource => (super.noSuchMethod(
        Invocation.getter(#localDataSource),
        returnValue: _FakeWeatherLocalDataSource_1(
          this,
          Invocation.getter(#localDataSource),
        ),
      ) as _i3.WeatherLocalDataSource);
  @override
  _i4.NetworkInfo get networkInfo => (super.noSuchMethod(
        Invocation.getter(#networkInfo),
        returnValue: _FakeNetworkInfo_2(
          this,
          Invocation.getter(#networkInfo),
        ),
      ) as _i4.NetworkInfo);
  @override
  _i8.Future<_i5.Either<_i9.Failure, _i10.CurrentWeather>>
      getCurrentWeather() => (super.noSuchMethod(
            Invocation.method(
              #getCurrentWeather,
              [],
            ),
            returnValue:
                _i8.Future<_i5.Either<_i9.Failure, _i10.CurrentWeather>>.value(
                    _FakeEither_3<_i9.Failure, _i10.CurrentWeather>(
              this,
              Invocation.method(
                #getCurrentWeather,
                [],
              ),
            )),
          ) as _i8.Future<_i5.Either<_i9.Failure, _i10.CurrentWeather>>);
}

/// A class which mocks [WeatherLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherLocalDataSource extends _i1.Mock
    implements _i3.WeatherLocalDataSource {
  MockWeatherLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i6.CurrentWeatherModel> getLastWeather() => (super.noSuchMethod(
        Invocation.method(
          #getLastWeather,
          [],
        ),
        returnValue: _i8.Future<_i6.CurrentWeatherModel>.value(
            _FakeCurrentWeatherModel_4(
          this,
          Invocation.method(
            #getLastWeather,
            [],
          ),
        )),
      ) as _i8.Future<_i6.CurrentWeatherModel>);
  @override
  _i8.Future<void> cacheWeather(_i6.CurrentWeatherModel? weatherModel) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheWeather,
          [weatherModel],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
}

/// A class which mocks [WeatherRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRemoteDataSource extends _i1.Mock
    implements _i2.WeatherRemoteDataSource {
  MockWeatherRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i6.CurrentWeatherModel> getWeather() => (super.noSuchMethod(
        Invocation.method(
          #getWeather,
          [],
        ),
        returnValue: _i8.Future<_i6.CurrentWeatherModel>.value(
            _FakeCurrentWeatherModel_4(
          this,
          Invocation.method(
            #getWeather,
            [],
          ),
        )),
      ) as _i8.Future<_i6.CurrentWeatherModel>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i4.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);
}
