import 'package:audioplayers/audioplayers.dart'; // 使用audioplayers库
import 'package:flutter/material.dart'; // 使用Flutter提供的UI库

/// 程序主入口
void main() {
  runApp(const MyApp()); // 运行App
}

/// 主Widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "VPlayer", // App标题
      home: Scaffold(
        // 一个页面
        appBar: AppBar(
          // 顶部栏
          title: const Text("宝批龙的手风琴"), // 标题
          backgroundColor: Colors.white, // 背景色
        ),
        backgroundColor: Colors.white38, // 页面背景色
        body: const PlayerMain(), // 页面主Widget
      ),
    );
  }
}

/// 主Widget的State
class PlayerMain extends StatefulWidget {
  const PlayerMain({super.key});

  @override
  State<StatefulWidget> createState() => _PlayerMain();
}

/// 主Widget的State
class _PlayerMain extends State<PlayerMain> {
  final audiosList = <Map<String, dynamic>>[
    // 音频列表
    {"srcnum": 1, "color": Colors.blue},
    {"srcnum": 2, "color": Colors.white},
    {"srcnum": 3, "color": Colors.red},
    {"srcnum": 4, "color": Colors.green},
    {"srcnum": 5, "color": Colors.purple},
    {"srcnum": 6, "color": Colors.amber},
    {"srcnum": 7, "color": Colors.indigo},
  ];
  void playSound(int soundNumber) {
    final player = AudioPlayer();
    player.play(AssetSource("audios/note$soundNumber.wav"));
  }

  //* 播放按钮
  Expanded playButton(BuildContext context, int sourceNumber, Color color) =>
      Expanded(
          child: Container(
        // 播放按钮背景
        color: color,
        child: TextButton(
          onPressed: () => playSound(sourceNumber),
          child: const Icon(Icons.play_arrow_rounded), // 播放按钮图标
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Column(
      // 列
      mainAxisSize: MainAxisSize.max, // 占满屏幕
      mainAxisAlignment: MainAxisAlignment.start, // 顶部对齐
      crossAxisAlignment: CrossAxisAlignment.stretch, // 宽度占满
      children: audiosList // 遍历音频列表
          .map((el) => playButton(context, el["srcnum"], el["color"])) // 生成播放按钮
          .toList(),
    );
  }
}
