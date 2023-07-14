import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weatheriran/core/fixture/fixture_reader.dart';
import 'package:weatheriran/features/current_weather/data/models/models.dart';
import 'package:weatheriran/features/current_weather/domain/entities/clouds.dart';

void main() {
  const tCloudsModel = CloudsModel(all: 100);

  group('from json', () {
    test('should return a valid model when the JSON Clouds is a Clouds model',
        () async {
      //arrenge
      final Map<String, dynamic> jsonMap = json.decode(fixture('clouds.json'));
      //act
      final result = CloudsModel.fromJson(jsonMap);
      //assert
      expect(result, tCloudsModel);
    });
  });
  test('should be a subclass of current Clouds entity', () async {
    expect(tCloudsModel, isA<Clouds>());
  });
  group('to Json', () {
    test('should return a Json map contaning the proper data', () async {
      //act
      final result = tCloudsModel.toJson();
      //asset
      final exceptedJson = {"all": 100};
      expect(result, exceptedJson);
    });
  });
}
