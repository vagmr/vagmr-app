import 'package:flutter/material.dart';
import 'package:flutterstart/test.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: const Text('Dicee'),
          centerTitle: true,
        ),
        body: const DicePage(),
      ),
    );
  }
}

//* 页面主体组件
class DicePage extends StatelessWidget {
  const DicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Image.asset("assets/images/dice1.png"),
        ),
        Expanded(
          child: Image.asset("assets/images/dice2.png"),
        ),
      ],
    );
  }
}
