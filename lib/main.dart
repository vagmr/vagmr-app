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
    {"src": "audios/note1.wav", "color": Colors.blue},
    {"src": "audios/note2.wav", "color": Colors.white},
    {"src": "audios/note3.wav", "color": Colors.red},
    {"src": "audios/note4.wav", "color": Colors.green},
    {"src": "audios/note5.wav", "color": Colors.purple},
    {"src": "audios/note6.wav", "color": Colors.amber},
    {"src": "audios/note7.wav", "color": Colors.indigo},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      // 列
      mainAxisSize: MainAxisSize.max, // 占满屏幕
      mainAxisAlignment: MainAxisAlignment.start, // 顶部对齐
      crossAxisAlignment: CrossAxisAlignment.stretch, // 宽度占满
      children: audiosList // 遍历音频列表
          .map((el) => playButton(context, el["src"], el["color"])) // 生成播放按钮
          .toList(),
    );
  }
}

/// 播放按钮
Widget playButton(BuildContext context, String source, Color color) => Expanded(
        child: Container(
      // 播放按钮背景
      color: color,
      child: TextButton(
        onPressed: () {
          final player = AudioPlayer(); // 创建播放器
          player.play(AssetSource(source)); // 播放音频
        },
        child: const Icon(Icons.play_arrow_rounded), // 播放按钮图标
      ),
    ));
