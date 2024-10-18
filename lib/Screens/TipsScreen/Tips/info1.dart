import 'package:flutter/material.dart';
import 'package:teledoctor_project/Components/TextBold.dart';
import 'package:teledoctor_project/Components/Textnormal.dart';

class Info1 extends StatefulWidget {
  const Info1({Key? key}) : super(key: key);

  @override
  State<Info1> createState() => _Info1State();
}

class _Info1State extends State<Info1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Understanding Blood Pressure Readings'),
      ),
      body: InteractiveViewer(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                TextBold(text: 'What do your blood pressure numbers mean?'),
                TextNormal(text: '\nThe only way to know if you have high blood pressure, also known as hypertension, is to have your blood pressure tested. Understanding your results is key to controlling high blood pressure.',),
                TextBold(text: '\nHealthy and unhealthy blood pressure ranges',),
                SizedBox(height: 10),
                Image.asset('assets/images/BP.png'),
                MaterialButton(
                  onPressed: (){}/*_launchURL*/,
                  color: Colors.blueAccent,
                  child: Text('To Read More'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// _launchURL() async {
//   const url = 'https://www.heart.org/en/health-topics/high-blood-pressure/understanding-blood-pressure-readings';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
