import 'package:weatheriran/features/current_weather/domain/entities/coord.dart';

class CoordModel extends Coord {
  const CoordModel({required super.lon, required super.lat});
  factory CoordModel.fromJson(Map<String, dynamic> json) {
    return CoordModel(lon: json['lon'], lat: json['lat']);
  }
  Map<String, dynamic> toJson() {
    return {'lon': lon, 'lat': lat};
  }
}
