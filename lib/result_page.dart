import 'package:flutter/material.dart';
import 'components/custom_button.dart';
import 'constants.dart';

enum BmiResult { underweight, normal, overweight, obesity }

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  Text resText(BmiResult bmiResult) {
    switch (bmiResult) {
      case BmiResult.underweight:
        return Text("偏瘦",
            style: TextStyle(
              color: Colors.cyan[200],
              fontSize: cardTextSize,
            ));

      case BmiResult.normal:
        return const Text("正常",
            style: TextStyle(
              color: Colors.green,
              fontSize: cardTextSize,
            ));
      case BmiResult.overweight:
        return const Text("偏胖",
            style: TextStyle(
              color: Colors.orange,
              fontSize: cardTextSize,
            ));
      case BmiResult.obesity:
        return const Text("肥胖",
            style: TextStyle(
              color: Colors.red,
              fontSize: cardTextSize,
            ));
    }
  }

  BmiResult calculateBmi(double bmi) {
    if (bmi < 18.5) {
      return BmiResult.underweight;
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return BmiResult.normal;
    } else if (bmi >= 25 && bmi <= 29.9) {
      return BmiResult.overweight;
    } else {
      return BmiResult.obesity;
    }
  }

  Text adviceText(BmiResult bmiResult) {
    if (bmiResult == BmiResult.underweight) {
      return const Text("建议增加饮食量，多吃高蛋白食物和健康脂肪。");
    } else if (bmiResult == BmiResult.normal) {
      return const Text("保持良好的饮食和运动习惯，继续保持！");
    } else if (bmiResult == BmiResult.overweight) {
      return const Text("建议控制饮食，增加运动量，以减轻体重。");
    } else {
      return const Text("建议立即咨询医生以获得专业建议。");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    int height = args['height'];
    int weight = args['weight'];
    double bmi = weight / ((height / 100) * (height / 100));
    return Scaffold(
      appBar: AppBar(
        title: const Text("结果显示"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 7,
              child: Card(
                  margin: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        resText(calculateBmi(bmi)),
                        Text(
                          bmi.toStringAsFixed(2),
                          style: kLargeBodyTextStyle,
                        ),
                        adviceText(calculateBmi(bmi))
                      ]))),
          Expanded(
              child: RouteButton(
            routeFunction: () {
              Navigator.pop(context);
            },
            btnText: "重新计算",
          ))
        ],
      ),
    );
  }
}
