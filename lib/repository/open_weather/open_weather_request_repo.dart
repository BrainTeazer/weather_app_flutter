import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_flutter/repository/open_weather/open_weather_repo.dart';
import 'package:weather_app_flutter/repository/open_weather/open_weather_uri.dart';
import 'package:weather_app_flutter/repository/request_repo.dart';

class OpenWeatherRequest extends Request {

  @override
  Future<http.Response> fetchRequest(uri, {args}) async {
    final OpenWeatherUri openWeatherUri = OpenWeatherUri.forWeather(baseUri: uri, units: args['units'], loc: args['loc'], apiKey: args['apiKey']);

    return http.get(openWeatherUri.toUri());
  }

  @override
  Future<Map<String, dynamic>> getResponse(uri, {args}) async {
    final response = await fetchRequest(uri, args:args);

    if(response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      final OpenWeather weather = OpenWeather.fromJson(decodedJson['weather'][0]);
      final OpenWeatherTemperature temperature = OpenWeatherTemperature.fromJson(decodedJson['main']);
      final OpenWeatherWind wind = OpenWeatherWind.fromJson(decodedJson['wind']);
      final String? name = decodedJson['name'];
      final String? country = decodedJson['sys']['country'];
      return {
        'weather': weather,
        'temperature': temperature,
        'wind': wind,
        'name': name,
        'country': country
      };
    } else {
      throw("Failed to load weather.");
    }
  }

}