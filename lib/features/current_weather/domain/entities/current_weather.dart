import 'package:equatable/equatable.dart';
import 'package:weatheriran/features/current_weather/domain/entities/clouds.dart';
import 'package:weatheriran/features/current_weather/domain/entities/coord.dart';
import 'package:weatheriran/features/current_weather/domain/entities/main_weather.dart';
import 'package:weatheriran/features/current_weather/domain/entities/sys.dart';
import 'package:weatheriran/features/current_weather/domain/entities/weather.dart';
import 'package:weatheriran/features/current_weather/domain/entities/wind.dart';

class CurrentWeather extends Equatable {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final MainWeather main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  const CurrentWeather(
      {required this.coord,
      required this.weather,
      required this.base,
      required this.main,
      required this.visibility,
      required this.wind,
      required this.clouds,
      required this.dt,
      required this.sys,
      required this.timezone,
      required this.id,
      required this.name,
      required this.cod});

  @override
  List<Object?> get props => [
        coord,
        base,
        weather,
        main,
        visibility,
        wind,
        clouds,
        dt,
        sys,
        timezone,
        id,
        name,
        cod
      ];
}
