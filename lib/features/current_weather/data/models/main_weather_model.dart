import 'package:weatheriran/features/current_weather/domain/entities/main_weather.dart';

class MainWeatherModel extends MainWeather {
  const MainWeatherModel(
      {required super.temp,
      required super.feelsLike,
      required super.tempMin,
      required super.tempMax,
      required super.pressure,
      required super.humidity});
  factory MainWeatherModel.fromJson(Map<String, dynamic> json) {
    return MainWeatherModel(
        temp: json['temp'],
        feelsLike: json['feels_like'],
        tempMin: json['temp_min'],
        tempMax: json['temp_max'],
        pressure: json['pressure'],
        humidity: json['humidity']);
  }
  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity
    };
  }
}
