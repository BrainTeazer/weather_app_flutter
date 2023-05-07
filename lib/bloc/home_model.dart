import 'package:weather_app_flutter/bloc/home_contract.dart';
import 'package:weather_app_flutter/constants.dart';
import 'package:weather_app_flutter/repository/location.dart';
import 'package:weather_app_flutter/repository/open_weather/open_weather_request_repo.dart';


class HomeModel implements Model {

  @override
  Future<Map<String, dynamic>> getOpenWeather(Location loc) async {
    final OpenWeatherRequest openWeatherRequest = OpenWeatherRequest();
    final args = {
      'loc': loc,
      'units': Constants.units,
      'apiKey': Constants.apiKey,
    };

    return await openWeatherRequest.getResponse(Constants.uriWeather, args: args);
  }

}