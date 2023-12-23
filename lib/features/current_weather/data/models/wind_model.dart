import 'package:weatheriran/features/current_weather/domain/entities/wind.dart';

class WindModel extends Wind {
  const WindModel({required super.speed, required super.deg});
  factory WindModel.fromJson(Map<String, dynamic> json) {
    return WindModel(
      speed: (json['speed'] as num).toDouble(),
      deg: (json['deg'] as num).toInt(),
    );
  }
  Map<String, dynamic> toJson() {
    return {'speed': speed, 'deg': deg};
  }
}
