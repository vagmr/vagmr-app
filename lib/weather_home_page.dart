import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'weather.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});
  @override
  WeatherHomePageState createState() => WeatherHomePageState();
}

class WeatherHomePageState extends State<WeatherHomePage> {
  Position? _position;
  LocationPermission? _permission;

  Alert showAlert({
    required BuildContext context,
    required AlertType type,
    String? title,
    String? desc,
    String confirmText = '确定',
    String cancelText = '取消',
  }) {
    return Alert(
        context: context,
        type: type,
        title: title ?? '提示',
        desc: desc,
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            color: const Color.fromRGBO(0, 179, 134, 1.0),
            child: Text(confirmText,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
          DialogButton(
              onPressed: () => Navigator.pop(context),
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0)
              ]),
              child: Text(
                cancelText,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ))
        ]);
  }

  Future<void> checkPermission() async {
    bool serviceEnabled;

    // 测试是否可以获取用户位置
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        showAlert(
          context: context,
          type: AlertType.error,
          title: '定位服务未开启',
          desc: '请在系统设置中打开定位服务',
        ).show();
      }
      return; // 返回,不继续执行下面的代码
    }

    // 查看现在的权限
    _permission = await Geolocator.checkPermission();

    // 如果没有权限
    if (_permission == LocationPermission.denied) {
      // 请求权限
      _permission = await Geolocator.requestPermission();

      // 依旧拒绝
      if (_permission == LocationPermission.denied) {
        // 展示拒绝弹窗
        if (mounted) {
          showAlert(
            context: context,
            type: AlertType.error,
            title: '定位权限被拒绝',
            desc: '定位权限被连续拒绝多次，请检查系统权限设置',
          ).show();
        }
        return; // 返回,不继续执行下面的代码
      }
    }

    if (_permission == LocationPermission.deniedForever) {
      if (mounted) {
        showAlert(
          context: context,
          type: AlertType.error,
          title: '定位权限被永久拒绝',
          desc: '请授予尝试打开定位权限',
        ).show();
      }
      return; // 返回,不继续执行下面的代码
    }

    // 当我们到达这里时,已经获得了权限,可以继续访问设备位置
    print(_permission); // 输出当前的权限状态

    try {
      if (_permission == LocationPermission.whileInUse ||
          _permission == LocationPermission.always) {
        // 获取当前位置
        _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest,
          timeLimit: const Duration(seconds: 5),
        );
        WeatherData weatherData =
            WeatherData(lat: _position!.latitude, lon: _position!.longitude);
        await weatherData.setWeather();
        print(weatherData.weatherDict);
        setState(() {}); // 更新UI
      }
    } catch (e) {
      if (mounted) {
        showAlert(
          context: context,
          title: "错误",
          desc: e.toString(),
          type: AlertType.error,
        ).show();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
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
            onPressed: () {
              checkPermission(); // 点击按钮时再次检查权限并获取位置
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white60,
              foregroundColor: const Color(0xFFf1356d),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: const Text('获取定位信息'),
          ),
          Text(_position == null ? '未获取到定位信息' : _position.toString())
        ],
      ),
    );
  }
}
