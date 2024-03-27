import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'show_alert.dart';
import 'loading.dart';
import 'location_screen.dart';
import 'weather_map.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});
  @override
  WeatherHomePageState createState() => WeatherHomePageState();
}

class WeatherHomePageState extends State<WeatherHomePage> {
  Position? _position;
  LocationPermission? _permission;
  Map<String, dynamic>? _pushData;

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
      final weatherModel = WeatherModel();
      var value =
          await weatherModel.getPositionAndData(permission: _permission);
      _position = value[0];
      _pushData = value[1];
      print(_pushData);
      setState(() {});
    } catch (e) {
      if (mounted) {
        Alert(
            context: context,
            title: "错误",
            desc: "${e.toString()},请尝试手动点击按钮获取",
            type: AlertType.error,
            buttons: [
              DialogButton(
                  child: const Text("取消"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]).show();
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
          _position == null
              ? const Loading()
              : TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationScreen(
                            pushData: _pushData!,
                          ),
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(top: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xFFf1356d),
                    ),
                    child: const Text('查看天气信息'),
                  )),
        ],
      ),
    );
  }
}
