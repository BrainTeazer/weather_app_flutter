import 'package:flutter/material.dart';
import 'package:weather_app_flutter/bloc/home_contract.dart';
import 'package:weather_app_flutter/bloc/home_model.dart';
import 'package:weather_app_flutter/bloc/home_view_model.dart';
import 'package:weather_app_flutter/constants.dart';
import 'package:weather_app_flutter/repository/location.dart';
import 'package:weather_app_flutter/repository/open_weather/open_weather_repo.dart';


const double weatherIconHeight = 150.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements View {

  Map<String, dynamic> _weatherItems = {};
  ViewModel? _viewModel;
  bool _loadingInProgress = true;

  Location loc = Location(lat: 53.0793, lon: 8.8017);

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(HomeModel(), this);
    _viewModel?.viewDisplayed(loc);
  }

  Image _getImage(String? weatherGroup) {
    switch(weatherGroup) {
      case 'Haze':{
        return Constants.getImage('haze.png', weatherIconHeight);
      }
      default: {
        return Constants.getImage('sunny.png', weatherIconHeight);
      }

    }
  }

  Widget _buildWeather(OpenWeather? openWeather) {
    return Column(

      children: [
        const SizedBox(height: 30),
        _getImage(openWeather?.weatherGroup),
        const SizedBox(height: 15),
        Text(openWeather?.weatherDescription ?? '')
      ],
    );
  }

  Widget _buildTemperature(OpenWeatherTemperature? openWeatherTemperature) {
    const double tempFont = 28.0;
    const double additionalInfoFont = 18.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            '${openWeatherTemperature?.temp}°',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: tempFont
          ),
        ),
        Text(
          'Feels like ${openWeatherTemperature?.feelsLike}°',
          style: const TextStyle(
          //fontWeight: FontWeight.w600,
          fontSize: additionalInfoFont
          ),
        ),
        Text(
          "Today's max: ${openWeatherTemperature?.tempMax}",
          style: const TextStyle(
            //fontWeight: FontWeight.w600,
              fontSize: additionalInfoFont
          ),

        ),
        Text(
            "Today's min: ${openWeatherTemperature?.tempMin}",
          style: const TextStyle(
            //fontWeight: FontWeight.w600,
              fontSize: additionalInfoFont
          ),
        ),
      ],
    );
    // return Text(
    //   '${openWeatherTemperature?.temp} ${openWeatherTemperature?.feelsLike} ${openWeatherTemperature?.tempMax} ${openWeatherTemperature?.tempMin} ',
    // );
  }

  Widget _buildWind(OpenWeatherWind? openWeatherWind) {
    return Column(
      children: [
        Transform.rotate(
            angle: openWeatherWind?.deg ?? 0.0,
            child: Constants.getImage('arrow.png', 28.0)
            // child: const Icon(
            //   Icons.keyboard_double_arrow_up_sharp,
            //   color: Colors.white,
            //   size: 28.0,
            // ),
        ),
        Text('${openWeatherWind?.speed} m/s'),
        Text('${openWeatherWind?.gust ?? ""}')
      ],
    );

  }

  Widget _buildList() {
    const double listPadding = 20.0;
    if (_loadingInProgress) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      children: [
        _buildWeather(_weatherItems['weather']),
        const SizedBox(height: listPadding),
        _buildTemperature(_weatherItems['temperature']),
        const SizedBox(height: listPadding),
        _buildWind(_weatherItems['wind']),
        const SizedBox(height: listPadding),
      ],
    );
    }
  }

  _changeLocationHandler() async {
    final result = await Navigator.pushNamed(context, '/changeLocation');

    if (result != null) {
      _loadingInProgress = true;
      _viewModel?.viewDisplayed(result as Location);
    }

  }

  PreferredSizeWidget _buildAppBar() {
    if(_loadingInProgress) {
      return AppBar(title: const Text(""));
    } else {
      return AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${_weatherItems['name']}, ${_weatherItems['country']}'),
              IconButton(icon: const Icon(Icons.location_city), onPressed: () => _changeLocationHandler())
            ],
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _viewModel?.viewDisplayed(loc),
      //   child: const Text("wow")
      // ),
      body: _buildList(),
    );
  }

  @override
  showWeather(Map<String, dynamic> response) {
    setState(() {
      _weatherItems = response;
      _loadingInProgress = false;
    });
  }

}