import 'package:weatheriran/features/search/domain/entities/search_city.dart';

class SearchCityModel extends SearchCity {
  const SearchCityModel({required super.lat, required super.lon});

  factory SearchCityModel.fromJson(Map<String, dynamic> json) {
    return SearchCityModel(lat: json['lat'], lon: json['lon']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}
