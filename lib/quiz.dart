import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'question.dart';

void main(List<String> args) => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "问答游戏",
      home: QuizHomePage(),
    );
  }
}

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _QuizHomePage();
}

class _QuizHomePage extends State<QuizHomePage> {
  //* 两种结果图标
  final Icon correctIcon = const Icon(
    Icons.check,
    color: Colors.green,
  );
  final Icon wrongIcon = const Icon(
    Icons.close,
    color: Colors.red,
  );
  //* 定义结果列表
  List<Icon> result = [];

  //* 定义当前问题
  int questionIndex = 0;
  //* 定义问题列表
  List<Question> questionsList = [
    Question(q: "如果一个人说\"我在撒谎\",那他说的是真话还是假话?", a: false),
    Question(
        q: "一个箱子里装了6个苹果,但是有几个是坏的。如果一个人从中拿出2个苹果,剩下的苹果全是好的。那一开始箱子里有多少个好苹果?",
        a: true),
    Question(
        q: "一个人去超市买了一只公鸡和一只母鸡,总共花费36元。如果公鸡比母鸡贵6倍,那公鸡和母鸡各自的价格是多少?", a: false),
    Question(q: "一个人说:\"今天是我生日的前一天。\"如果今天是星期四,那他的生日是星期几?", a: true)
  ];

  // * 使用变量存储是否为最后一题
  bool isLastQuestion = false;

  // // 制作处理结果的函数(已完成)
  void handleResult({List result = const [], required bool choice}) {
    setState(() {
      if (questionIndex == questionsList.length - 1) {
        isLastQuestion = true;
        Alert(
            context: context,
            title: "提示",
            type: AlertType.info,
            desc: "所有问题已回答完毕",
            buttons: [
              DialogButton(
                  child: const Text("确定"),
                  onPressed: () => Navigator.pop(context))
            ]).show();
      }
      if (questionIndex < questionsList.length) {
        result.add(choice == questionsList[questionIndex].isCorrect()
            ? correctIcon
            : wrongIcon);
        questionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("问答游戏"),
        ),
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      isLastQuestion
                          ? "所有问题已回答完毕"
                          : questionsList[questionIndex].getQuestion(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.green),
                  onPressed: isLastQuestion
                      ? null
                      : () => handleResult(result: result, choice: true),
                  child: const Text(
                    "正确",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.red,
                ),
                onPressed: isLastQuestion
                    ? null
                    : () => handleResult(result: result, choice: false),
                child: const Text(
                  "错误",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10.0,
                  ),
                  SizedBox(
                    height: 30, // 设定一个合适的最小高度
                    child: Row(
                      children: result.isNotEmpty
                          ? result
                          : [Container()], // 当result为空时显示空容器
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
