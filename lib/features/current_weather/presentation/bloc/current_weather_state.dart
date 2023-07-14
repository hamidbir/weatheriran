part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState extends Equatable {
  const CurrentWeatherState() : super();

  @override
  List<Object> get props => [];
}

class CurrentWeatherInitial extends CurrentWeatherState {}

class Empty extends CurrentWeatherState {}

class Loading extends CurrentWeatherState {}

class Loaded extends CurrentWeatherState {
  final CurrentWeather weather;

  const Loaded(this.weather);

  @override
  List<Object> get props => [weather];
}

class Error extends CurrentWeatherState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
