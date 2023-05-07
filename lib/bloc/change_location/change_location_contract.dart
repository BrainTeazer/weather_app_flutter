abstract class Model {
  Future <dynamic> getLocations(String? cityName);
}

abstract class View {
  showLocations(List<dynamic> locations);
}

abstract class ViewModel {
  viewDisplayed(String? cityName);
}