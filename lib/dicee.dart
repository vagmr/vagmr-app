import 'dart:math';

import 'package:flutter/material.dart';

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
          backgroundColor: Colors.red,
        ),
        body: const DicePage(),
      ),
    );
  }
}

//* 页面主体组件
class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 2;
  void changeNumber() => {
        setState(() {
          leftDiceNumber = Random().nextInt(6) + 1;
          rightDiceNumber = Random().nextInt(6) + 1;
        })
      };
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextButton(
            child: Image.asset("assets/images/dice$leftDiceNumber.png"),
            onPressed: () {
              changeNumber();
            },
          )),
          const SizedBox(width: 20),
          Expanded(
              child: TextButton(
            child: Image.asset("assets/images/dice$rightDiceNumber.png"),
            onPressed: () {
              changeNumber();
            },
          )),
        ],
      ),
    );
  }
}
