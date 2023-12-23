import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatheriran/core/error/exception.dart';
import 'package:weatheriran/features/search/data/models/search_city_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchCityModel> searchingCity(String name);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final http.Client client;
  SearchRemoteDataSourceImpl({required this.client});
  @override
  Future<SearchCityModel> searchingCity(String name) {
    return _getWeatherFromUrl(
        'https://api.openweathermap.org/geo/1.0/direct?q=$name&appid=e9c9866d36637dbc23dbff654e160d61');
  }

  Future<SearchCityModel> _getWeatherFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      debugPrint('${response.body.isEmpty}');
      debugPrint('${response.body.length}');
      if (response.body.length != 2) {
        dynamic parsedJson = json.decode(response.body);
        debugPrint(' parsed json: $parsedJson');
        final hamid = (parsedJson as List<dynamic>)
            .map((job) => SearchCityModel.fromJson(job))
            .toList();
        debugPrint('$hamid');

        return hamid[0];
      } else {
        throw NotFoundException();
      }
    } else {
      throw ServerException();
    }
  }
}
