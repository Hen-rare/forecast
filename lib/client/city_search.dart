import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CitySearch {
  final String _apiKey = 'O7JxChOafVJ6X1UMsfnqCBGZ8MffRV7G';
  final String _url = 'dataservice.accuweather.com';
  final String _path = 'locations/v1/cities/search';

  Future<List<Map<String, String>>> search(String query) async{
    Uri uri = Uri.https(_url, _path, {
      'apikey': _apiKey,
      'q': query
    });
    http.Response cities = await http.get(uri, headers:{
      HttpHeaders.contentTypeHeader : 'application/json'
    } );

    debugPrint(cities.body);
    List<dynamic> formatCities = json.decode(cities.body) ?? [];

    List<Map<String, String>> citiesData = [];
    for (var city in formatCities) {
      Map<String, String> data = {
        'key' : city['Key'],
        'city' : city['EnglishName'],
        'state' : city['AdministrativeArea']['EnglishName'],
        'country' : city['Country']['EnglishName'],
      };

      citiesData.add(data);
    }
    return citiesData;
  }
}