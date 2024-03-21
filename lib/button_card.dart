import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'package:vagmr_app/components/custom_button.dart';

class ButtonCard extends StatelessWidget {
  // * 一个由text和两个按钮组成的卡片组件
  final int variable;
  final void Function() increase;
  final void Function() decrease;
  final String title;
  final String unit;
  const ButtonCard(
      {super.key,
      required this.variable,
      required this.increase,
      required this.decrease,
      required this.title,
      required this.unit});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(title, style: kTextStyle),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text("$variable", style: kLargeBodyTextStyle),
              Text(unit, style: kTextStyle),
            ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          RoundIconButton(
            buttonChild: const Icon(FontAwesomeIcons.minus),
            onPressed: decrease,
          ),
          const SizedBox(
            width: 10.0,
          ),
          RoundIconButton(
              buttonChild: const Icon(FontAwesomeIcons.plus),
              onPressed: increase),
        ])
      ],
    );
  }
}
