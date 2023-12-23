import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weatheriran/core/fixture/fixture_reader.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';
import 'package:weatheriran/features/current_weather/domain/entities/coord.dart';

void main() {
  const tCoordModel = CoordModel(lon: 59.2177, lat: 32.8634);

  group('from json', () {
    test('should return a valid model when the JSON Coord is a Coord model',
        () async {
      //arrenge
      final Map<String, dynamic> jsonMap = json.decode(fixture('coord.json'));
      //act
      final result = CoordModel.fromJson(jsonMap);
      //assert
      expect(result, tCoordModel);
    });
  });
  test('should be a subclass of current Coord entity', () async {
    expect(tCoordModel, isA<Coord>());
  });

  group('to Json', () {
    test('should return a Json map contaning the proper data', () async {
      //act
      final result = tCoordModel.toJson();
      //asset
      final exceptedJson = {"lon": 59.2177, "lat": 32.8634};
      expect(result, exceptedJson);
    });
  });
}
