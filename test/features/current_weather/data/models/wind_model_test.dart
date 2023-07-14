import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weatheriran/core/fixture/fixture_reader.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';
import 'package:weatheriran/features/current_weather/domain/entities/wind.dart';

void main() {
  const tWindModel = WindModel(speed: 15.95, deg: 220);

  group('from json', () {
    test('should return a valid model when the JSON Wind is a Wind model',
        () async {
      //arrenge
      final Map<String, dynamic> jsonMap = json.decode(fixture('wind.json'));
      //act
      final result = WindModel.fromJson(jsonMap);
      //assert
      expect(result, tWindModel);
    });
  });
  test('should be a subclass of current Wind entity', () async {
    expect(tWindModel, isA<Wind>());
  });
  group('to Json', () {
    test('should return a Json map contaning the proper data', () async {
      //act
      final result = tWindModel.toJson();
      print(result.runtimeType);
      //asset
      final exceptedJson = {"speed": 15.95, "deg": 220};
      expect(result, exceptedJson);
    });
  });
}
