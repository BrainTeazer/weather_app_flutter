abstract class Geocode {
  final String? cityName;

  Geocode(this.cityName);

  Future<dynamic> getGeocode(uri, {args});
}