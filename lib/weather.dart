import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'net_helper.dart';
import 'dart:convert';

class WeatherData {
  final double lat;
  final double lon;
  Map<String, dynamic> weatherDict;

  WeatherData(
      {required this.lat, required this.lon, Map<String, dynamic>? weatherDict})
      : weatherDict = weatherDict ?? const {};

  Future<void> setWeather() async {
    await dotenv.load(fileName: '.env');
    final apiKey = dotenv.get('apikey');
    NetHelper netHelper = NetHelper(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey");
    var res = await netHelper.getData();
    weatherDict = jsonDecode(res.body);
  }
}
