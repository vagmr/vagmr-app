import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'custom_components.dart' as SkillBar;

void main() {
  runApp(const MyApp());
}

class MyInfo extends StatelessWidget {
  final String info;
  final IconData icon;

  const MyInfo({
    super.key,
    required this.info,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      color: Colors.white,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Text(
            info,
            style: const TextStyle(fontSize: 18.0),
          ),
          leading: Icon(
            icon,
            color: const Color.fromARGB(255, 233, 15, 142),
            size: 30.0,
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  _onLaunchUrl() async {
    const url = 'https://vagmr.github.io/cv/';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          title: const Center(
            child: Text("Mini Cv Card"),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            // Wrap with SingleChildScrollView
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage("assets/images/author.jpg"),
                ),
                const Text(
                  "vagmr",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lugrasimo',
                      fontWeight: FontWeight.w700,
                      fontSize: 30.0),
                ),
                Text(
                  "web developer".toUpperCase(),
                  style: TextStyle(
                      color: Colors.teal[100],
                      fontFamily: "Lato",
                      letterSpacing: 2.0,
                      fontSize: 20.0),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: const Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                ),
                // * 个人信息
                const MyInfo(info: "Phone: 15897732520", icon: Icons.phone),
                const MyInfo(
                    info: "Email: vagmr@example.com", icon: Icons.email),
                // * 技能条
                const Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SkillBar.LineSkillBar(skillName: "Flutter", process: 50),
                      SkillBar.LineSkillBar(skillName: "Dart", process: 40),
                      SkillBar.LineSkillBar(skillName: "Vue", process: 65),
                      SkillBar.LineSkillBar(skillName: "C++", process: 20),
                      SkillBar.LineSkillBar(skillName: "Java", process: 40),
                      SkillBar.LineSkillBar(skillName: "Python", process: 70)
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: _onLaunchUrl,
                    child: const Text(
                      "web review",
                      style: TextStyle(fontSize: 20.0),
                    )),
                Container(
                  width: double.infinity,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
