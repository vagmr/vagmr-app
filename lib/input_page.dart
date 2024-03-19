import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "icon_content.dart";

const cardColor = Color(0xFF1D1E33);
const backgroundColor = Color(0xFF0A0E21);
const activeColor = Colors.white;

enum Gender { male, female }

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

  Expanded buildRow(
      {Widget? firstChild,
      Widget? secondChild,
      Color? firstCardColor,
      Color? secondCardColor}) {
    return Expanded(
        child: Row(
      children: [
        Expanded(
          child: ContainerComponent(
            color: firstCardColor,
            child: firstChild,
          ),
        ),
        Expanded(
          child: ContainerComponent(color: secondCardColor, child: secondChild),
        ),
      ],
    ));
  }

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
    return Scaffold(
        appBar: AppBar(
          title: const Text('BMI CALCULATOR'),
          centerTitle: true,
          backgroundColor: backgroundColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //* 性别选择按钮
            buildRow(
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

            const Expanded(child: ContainerComponent()),
            buildRow(),
            Container(
              color: const Color(0xFFEB1555),
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              width: double.infinity,
              height: 60.0,
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
