import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weatheriran/core/fixture/fixture_reader.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';
import 'package:weatheriran/features/current_weather/domain/entities/sys.dart';

void main() {
  const tSysModel = SysModel(
      type: 1,
      id: 7481,
      country: 'IR',
      sunrise: 1680831836,
      sunset: 1680877589);

  group('from json', () {
    test('should return a valid model when the JSON Sys is a Main Sys model',
        () async {
      //arrenge
      final Map<String, dynamic> jsonMap = json.decode(fixture('sys.json'));
      //act
      final result = SysModel.fromJson(jsonMap);
      //assert
      expect(result, tSysModel);
    });
  });
  test('should be a subclass of current Sys entity', () async {
    expect(tSysModel, isA<Sys>());
  });

  group('to Json', () {
    test('should return a Json map contaning the proper data', () async {
      //act
      final result = tSysModel.toJson();
      //asset
      final exceptedJson = {
        "type": 1,
        "id": 7481,
        "country": "IR",
        "sunrise": 1680831836,
        "sunset": 1680877589
      };
      expect(result, exceptedJson);
    });
  });
}
