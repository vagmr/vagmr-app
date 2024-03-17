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
        appBar: AppBar(
          title: const Text("Ask me questions"),
          backgroundColor: Colors.blue[900]!,
        ),
        backgroundColor: Colors.blue[300],
        body: const BallPage(),
      ),
    );
  }
}

class BallPage extends StatefulWidget {
  const BallPage({super.key});

  @override
  State<BallPage> createState() => _BallPageState();
}

class _BallPageState extends State<BallPage> {
  int ballNumber = 1;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Image.asset('assets/images/ball$ballNumber.png'),
      onPressed: () {
        setState(() {
          ballNumber = Random().nextInt(5) + 1;
        });
      },
    );
  }
}
