import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {
  final IconData iconData;
  final String text;
  const IconContent({super.key, required this.iconData, required this.text});
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(iconData, size: 60.0),
      Text(
        text,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      ),
    ]);
  }
}
