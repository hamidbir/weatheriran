import 'package:weatheriran/features/current_weather/domain/entities/sys.dart';

class SysModel extends Sys {
  const SysModel(
      {required super.type,
      required super.id,
      required super.country,
      required super.sunrise,
      required super.sunset});
  factory SysModel.fromJson(Map<String, dynamic> json) {
    return SysModel(
        type: json['type'] ?? 0,
        id: json['id'] ?? 0,
        country: json['country'],
        sunrise: json['sunrise'],
        sunset: json['sunset']);
  }
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'id': id,
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset
    };
  }
}
