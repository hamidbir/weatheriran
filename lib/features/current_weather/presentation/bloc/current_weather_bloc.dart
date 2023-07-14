import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatheriran/core/error/failure.dart';
import 'package:weatheriran/core/usecases/usecase.dart';
import 'package:weatheriran/features/current_weather/domain/entities/current_weather.dart';
import 'package:weatheriran/features/current_weather/domain/usecases/get_current_weather.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid input - The Number must be a positive integer or zero.';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final GetCurrentWeather getWeather;
  final GetCurrentWeatherWithGeo getWeatherWithGeo;

  CurrentWeatherState get initialState => Empty();
  CurrentWeatherBloc(
      {required this.getWeather, required this.getWeatherWithGeo})
      : super(Empty()) {
    on<UpdatingWeather>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getWeather(NoParams());
      failureOrTrivia.fold((failure) {
        emit(Error(_mapFailureToMessage(failure)));
      }, (weather) {
        emit(Loaded(weather));
      });
    });
    on<UpdatingWeatherWithGeo>((event, emit) async {
      emit(Loading());
      final cityParams = CityParams(event.lat, event.lon);
      final failureOrTrivia = await getWeatherWithGeo(cityParams);
      failureOrTrivia.fold((failure) {
        emit(Error(_mapFailureToMessage(failure)));
      }, (weather) {
        emit(Loaded(weather));
      });
    });
    on<UpdatingWeatherWithLoc>((event, emit) async {
      emit(Loading());
      bool servicestatus = await Geolocator.isLocationServiceEnabled();

      if (servicestatus) {
        print("GPS service is enabled");
      } else {
        print("GPS service is disabled.");
      }
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          print("GPS Location service is granted");
        }
      } else {
        print("GPS Location permission granted.");
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457
      final cityParams = CityParams(position.latitude, position.longitude);
      final failureOrTrivia = await getWeatherWithGeo(cityParams);
      failureOrTrivia.fold((failure) {
        emit(Error(_mapFailureToMessage(failure)));
      }, (weather) {
        emit(Loaded(weather));
      });
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;

    default:
      return 'Unexpected error';
  }
}
