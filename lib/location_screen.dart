import 'package:flutter/material.dart';
import "constants.dart";
import 'weather_map.dart';
import 'city_screen.dart';
import 'weather.dart';

class LocationScreen extends StatefulWidget {
  final Map<String, dynamic> pushData;
  const LocationScreen({super.key, required this.pushData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late Map<String, dynamic> renderData;
  late String weatherIcon;
  late String weatherMsg;
  late double temp;

  @override
  void initState() {
    super.initState();
    renderData = widget.pushData;
    weatherIcon = WeatherModel().getWeatherIcon(renderData['weather'][0]['id']);
    temp = renderData['main']['temp'];
    weatherMsg =
        "${WeatherModel().getMessage(temp.toInt())} in ${renderData['name']}";
  }

  void _update_ui(dynamic data) {
    setState(() {
      renderData = data;
      weatherIcon =
          WeatherModel().getWeatherIcon(renderData['weather'][0]['id']);
      temp = renderData['main']['temp'];
      weatherMsg =
          "${WeatherModel().getMessage(temp.toInt())} in ${renderData['name']}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      if (cityName != null) {
                        WeatherData weatherData = WeatherData();
                        await weatherData.setWeatherByName(cityName);

                        _update_ui(weatherData.weatherDict);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temp.toStringAsFixed(0)}°C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherMsg,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
