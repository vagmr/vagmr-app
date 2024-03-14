import 'package:flutter/material.dart';

// * main函数是flutter应用的入口
void main() => runApp(MaterialApp(
        // *center组件用于居中显示
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Hello Flutter'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      backgroundColor: const Color.fromARGB(255, 107, 103, 103),
      body: const Center(
          child: Image(
        image: AssetImage('assets/images/code.png'),
      )),
    )));
