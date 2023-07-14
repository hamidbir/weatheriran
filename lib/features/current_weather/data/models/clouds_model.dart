import 'package:weatheriran/features/current_weather/domain/entities/clouds.dart';

class CloudsModel extends Clouds {
  const CloudsModel({required super.all});
  factory CloudsModel.fromJson(Map<String, dynamic> json) {
    return CloudsModel(all: json['all']);
  }

  Map<String, dynamic> toJson() {
    return {'all': all};
  }
}
