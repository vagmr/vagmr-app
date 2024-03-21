import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final Widget buttonChild;
  final VoidCallback? onPressed;
  const RoundIconButton({super.key, required this.buttonChild, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed ?? () {},
      // * 按钮的突起
      elevation: 6.0,
      // * 按钮约束大小
      constraints: const BoxConstraints.tightFor(
        width: 56.0,
        height: 50.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      fillColor: const Color(0xFF4C4F5E),
      child: buttonChild,
    );
  }
}

class RouteButton extends StatelessWidget {
  final VoidCallback routeFunction;
  final String btnText;
  const RouteButton(
      {super.key, required this.routeFunction, this.btnText = "计算"});

  @override
  Widget build(Object context) {
    return Container(
      color: const Color(0xFFEB1555),
      margin: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
      width: double.infinity,
      height: 60.0,
      child: TextButton(
        onPressed: routeFunction,
        child: Text(btnText, style: const TextStyle(fontSize: 20.0)),
      ),
    );
  }
}
