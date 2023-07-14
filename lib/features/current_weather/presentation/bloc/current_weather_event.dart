part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();

  @override
  List<Object> get props => [];
}

class UpdatingWeather extends CurrentWeatherEvent {}

class UpdatingWeatherWithLoc extends CurrentWeatherEvent {}

class UpdatingWeatherWithGeo extends CurrentWeatherEvent {
  final double lat;
  final double lon;

  const UpdatingWeatherWithGeo(this.lat, this.lon);

  @override
  List<Object> get props => [lat, lon];
}
