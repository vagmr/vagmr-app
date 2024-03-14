import 'package:flutter/material.dart';

class LineSkillBar extends StatelessWidget {
  final String skillName;
  final int process;

  const LineSkillBar(
      {super.key, required this.skillName, required this.process});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          children: [
            Text(
              skillName,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    value: process / 100,
                    minHeight: 15.0,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.green[400]!),
                  ),
                  const SizedBox(height: 1.0),
                  Center(
                    child: Text(
                      '$process%',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
