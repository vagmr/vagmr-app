import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "icon_content.dart";
import 'constants.dart';
import 'button_card.dart';
import 'components/custom_button.dart';

enum Gender { male, female }

//* 点击按钮样式
ButtonStyle clickBtnStyle = ButtonStyle(
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(0),
)));

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  InputPageState createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
  Color maleColor = cardColor;
  Color femaleColor = cardColor;
  int height = 160;
  int weight = 60;
  int age = 18;

  //* 通用行组件
  // Creates an expanded row with two children, each wrapped in a container component with specified colors.
  Expanded buildRow(
      {Widget? firstChild,
      Widget? secondChild,
      Color? firstCardColor,
      Color? secondCardColor,
      int? flex}) {
    return Expanded(
        flex: flex ?? 1,
        child: Row(
          children: [
            Expanded(
              child: ContainerComponent(
                color: firstCardColor,
                child: firstChild,
              ),
            ),
            Expanded(
              child: ContainerComponent(
                  color: secondCardColor, child: secondChild),
            ),
          ],
        ));
  }

  //* 性别选择
  void choiceGender(Gender gender) {
    setState(() {
      if (gender == Gender.male) {
        maleColor = maleColor == cardColor ? activeColor : cardColor;
        femaleColor = cardColor;
      } else if (gender == Gender.female) {
        femaleColor = femaleColor == cardColor ? activeColor : cardColor;
        maleColor = cardColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 一个以BuildContext作为参数并返回Scaffold小部件的构建函数。
    return Scaffold(
        appBar: AppBar(
          title: const Text('BMI 计算器'),
          centerTitle: true,
          backgroundColor: backgroundColor,
        ),
        //! 页面主要布局
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //* 性别选择按钮分区
            buildRow(
              flex: 2,
              firstChild: TextButton(
                  onPressed: () => choiceGender(Gender.male),
                  style: clickBtnStyle,
                  child: const IconContent(
                      iconData: FontAwesomeIcons.marsStrokeUp, text: "男性")),
              secondChild: TextButton(
                  onPressed: () => choiceGender(Gender.female),
                  style: clickBtnStyle,
                  child: const IconContent(
                      iconData: FontAwesomeIcons.venus, text: "女性")),
              firstCardColor: maleColor,
              secondCardColor: femaleColor,
            ),
            // * 身高选择组件
            Expanded(
                flex: 3,
                child: ContainerComponent(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("选择身高", style: kTextStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "$height",
                            style: kLargeBodyTextStyle,
                          ),
                          const Text("cm", style: kTextStyle),
                        ],
                      ),
                      //TODO 制作滑动条以调整身高
                      SizedBox(
                        height: 30.0, // 适应屏幕高度
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              // * 滑动条按钮样式
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 14.0),
                              // * 滑动条按钮外圈大小
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 26.0,
                              ),
                              thumbColor: const Color(0xFFEB1555),
                              overlayColor: const Color(0x29EB1555),
                              // * 滑动条背景颜色
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: const Color(0xFF8D8E98)),
                          child: Slider(
                            value: height.toDouble(),
                            min: 100.0,
                            max: 220.0,
                            onChanged: (double newValue) {
                              setState(() {
                                height = newValue.round();
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            // 下面的两个卡片
            buildRow(
              // * 体重选择组件
              flex: 3,
              firstChild: ButtonCard(
                  variable: weight,
                  title: "体重",
                  unit: "kg",
                  increase: () => setState(() {
                        weight++;
                      }),
                  decrease: () => setState(() {
                        weight--;
                      })),
              secondChild: ButtonCard(
                  variable: age,
                  increase: () => setState(() {
                        age++;
                      }),
                  decrease: () => setState(() {
                        age--;
                      }),
                  title: "年龄",
                  unit: "岁"),
            ),
            // * 最下面的跳转按钮
            RouteButton(
              routeFunction: () =>
                  Navigator.pushNamed(context, "/res", arguments: {
                "height": height,
                "weight": weight,
              }),
            )
          ],
        ));
  }
}

// 单独提出一个组件
class ContainerComponent extends StatelessWidget {
  final Color? color;
  final Widget? child;

  const ContainerComponent({super.key, this.color, this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: color ?? cardColor,
          ),
          child: child,
        ));
  }
}
