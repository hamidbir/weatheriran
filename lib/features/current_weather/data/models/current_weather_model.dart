import 'package:weatheriran/features/current_weather/data/models/models.dart';
import 'package:weatheriran/features/current_weather/domain/entities/coord.dart';
import 'package:weatheriran/features/current_weather/domain/entities/current_weather.dart';
import 'package:weatheriran/features/current_weather/domain/entities/weather.dart';

class CurrentWeatherModel extends CurrentWeather {
  const CurrentWeatherModel(
      {required super.coord,
      required super.weather,
      required super.base,
      required super.main,
      required super.visibility,
      required super.wind,
      required super.clouds,
      required super.dt,
      required super.sys,
      required super.timezone,
      required super.id,
      required super.name,
      required super.cod});
  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    List<Weather> weather = [];
    if (json['weather'] != null) {
      weather = (json['weather'] as List)
          .map((wJson) => WeatherModel.fromJson(wJson))
          .toList();
    }
    return CurrentWeatherModel(
        coord: CoordModel.fromJson(json['coord']),
        weather: weather,
        base: json['base'],
        main: MainWeatherModel.fromJson(json['main']),
        visibility: json['visibility'],
        wind: WindModel.fromJson(json['wind']),
        clouds: CloudsModel.fromJson(json['clouds']),
        dt: json['dt'],
        sys: SysModel.fromJson(json['sys']),
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod']);
  }
  Map<String, dynamic> toJson() {
    return {
      'coord': {'lon': coord.lon, 'lat': coord.lat},
      'weather': weather
          .map((item) => {
                'id': item.id,
                'main': item.main,
                'description': item.description,
                'icon': item.icon
              })
          .toList(),
      'base': base,
      'main': {
        'temp': main.temp,
        'feels_like': main.feelsLike,
        'temp_min': main.tempMin,
        'temp_max': main.tempMax,
        'pressure': main.pressure,
        'humidity': main.humidity
      },
      'visibility': visibility,
      'wind': {'speed': wind.speed, 'deg': wind.deg},
      'clouds': {'all': clouds.all},
      'dt': dt,
      'sys': {
        'type': sys.type,
        'id': sys.id,
        'country': sys.country,
        'sunrise': sys.sunrise,
        'sunset': sys.sunset
      },
      'timezone': timezone,
      'id': id,
      'name': name,
      'cod': cod,
    };
  }
}
