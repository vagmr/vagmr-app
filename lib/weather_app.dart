import 'package:flutter/material.dart';
import 'weather_home_page.dart';

void main(List<String> args) => runApp(const WeatherApp());

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(title: const Text('Weather App')),
          body: const WeatherHomePage(),
        ));
  }
}
