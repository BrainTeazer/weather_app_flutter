import 'package:weather_app_flutter/bloc/change_location/change_location_contract.dart';
import 'package:weather_app_flutter/constants.dart';
import 'package:weather_app_flutter/repository/open_weather/open_weather_geocode_repo.dart';

class ChangeLocationModel implements Model {
  @override
  Future getLocations(String? cityName) async {
    if (cityName != null) {
      final OpenWeatherGeocode openWeatherGeocode = OpenWeatherGeocode();

      final args = {
        'cityName': cityName,
        'limit': Constants.limit.toString(),
        'apiKey': Constants.apiKey
      };

      return await openWeatherGeocode.getGeocode(
          Constants.uriGeocode, args: args);
    }
  }
}