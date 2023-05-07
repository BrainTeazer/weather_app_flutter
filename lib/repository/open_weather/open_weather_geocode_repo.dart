import 'dart:convert';

import 'package:weather_app_flutter/repository/geocode_repo.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_flutter/repository/location.dart';
import 'package:weather_app_flutter/repository/open_weather/open_weather_uri.dart';


class OpenWeatherGeocode implements Geocode {

  @override
  String? cityName;


  // make a request to get a response from OpenWeather's Geocoding API
  Future<http.Response> _fetchRequest(uri, {args}) async {
    final OpenWeatherUri openWeatherUriGeocode = OpenWeatherUri.forGeocode(baseUri: uri, cityName: args['cityName'], limit: args['limit'], apiKey: args['apiKey']);
    return http.get(openWeatherUriGeocode.toUriGeocode());
  }

  //
  @override
  Future<List<dynamic>> getGeocode(uri, {args}) async {
    final response = await _fetchRequest(uri, args: args);

    if (response.statusCode == 200) {
        final List<dynamic> decodedJson = jsonDecode(response.body);
        final allLocations = [];

        for(final value in decodedJson) {
          allLocations.add({
            'loc': Location(lat: value['lat'], lon: value['lon']),
            'name': value['name'],
            'country': value['country']
          });
        }

        return allLocations;
    } else {
      throw("Failed to retrieve location.");
    }
  }
}