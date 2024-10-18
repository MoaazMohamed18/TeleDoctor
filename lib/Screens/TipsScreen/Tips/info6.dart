import 'package:flutter/material.dart';
import 'package:teledoctor_project/Components/TextBold.dart';
import 'package:teledoctor_project/Components/Textnormal.dart';

class Info6 extends StatefulWidget {
  const Info6({Key? key}) : super(key: key);

  @override
  State<Info6> createState() => _Info6State();
}

class _Info6State extends State<Info6> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Reduce stress'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              TextNormal(text: "Try these Tips to ward off ongoing stress and its many health risks, such as chronic inflammation and chronic disease."),
              TextNormal(text: '\n- Do a relaxation exercise.'
                  "\n- Stretch your muscles."
                  "\n- Take a mindfulness break."
                  "\n- Take a brisk walk."
                  "\n- Reduce loud noise in your environment."
                  "\n- Counter negative thoughts."
                  "\n- Use positive self-talk."
              ),
              MaterialButton(
                onPressed: (){}/*_launchURL*/,
                color: Colors.lightGreen,
                child: Text('To Read More'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// _launchURL() async {
//   const url = 'https://www.health.harvard.edu/staying-healthy/top-ways-to-reduce-daily-stress';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
