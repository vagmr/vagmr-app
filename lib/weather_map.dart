import 'package:geolocator/geolocator.dart';
import 'weather.dart';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future getPositionAndData(
      {LocationPermission? permission, String? url}) async {
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // 获取当前位置
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.lowest,
        timeLimit: const Duration(seconds: 5),
      );
      WeatherData weatherData =
          WeatherData(lat: position.latitude, lon: position.longitude);
      await weatherData.setWeather();
      final pushData = weatherData.weatherDict;
      return [position, pushData]; // 更新UI
    }
  }
}
