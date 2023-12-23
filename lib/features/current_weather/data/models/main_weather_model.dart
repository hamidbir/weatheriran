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
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      tempMin: (json['temp_min']).toDouble(),
      tempMax: (json['temp_max']).toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
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
