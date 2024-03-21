import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});
  @override
  WeatherHomePageState createState() => WeatherHomePageState();
}

class WeatherHomePageState extends State<WeatherHomePage> {
  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('主页面', style: TextStyle(fontSize: 30)),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => getLocation(),
          style: TextButton.styleFrom(
            backgroundColor: Colors.white60,
            foregroundColor: const Color(0xFFf1356d),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            textStyle: const TextStyle(fontSize: 20),
          ),
          child: const Text('获取定位信息'),
        )
      ],
    ));
  }
}
