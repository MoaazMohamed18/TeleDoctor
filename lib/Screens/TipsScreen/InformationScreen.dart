import 'package:flutter/material.dart';
import 'package:teledoctor_project/Components/BottomAppBar.dart';
import 'package:teledoctor_project/Components/BoxButton.dart';
import 'package:teledoctor_project/Screens/HomeScreen/HomeScreen.dart';
import 'package:teledoctor_project/Screens/TipsScreen/Tips/info1.dart';
import 'package:teledoctor_project/Screens/TipsScreen/Tips/info2.dart';
import 'package:teledoctor_project/Screens/TipsScreen/Tips/info3.dart';
import 'package:teledoctor_project/Screens/TipsScreen/Tips/info4.dart';
import 'package:teledoctor_project/Screens/TipsScreen/Tips/info5.dart';
import 'package:teledoctor_project/Screens/TipsScreen/Tips/info6.dart';
import 'package:teledoctor_project/Screens/TipsScreen/Tips/info7.dart';


class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BoxButton(
                image: 'assets/images/bloodpr.png',
                color: Colors.blueAccent,
                text: 'Understanding Blood Pressure Readings',
                Screen: Info1(),
              ),
              SizedBox(height: 20),
              BoxButton(
                image: 'assets/images/highp.png',
                color: Colors.indigoAccent,
                text: 'Risk Factors of Blood Pressue',
                Screen: Info2(),
              ),
              SizedBox(height: 20),
              BoxButton(
                image: 'assets/images/pulse.png',
                color: Colors.indigo,
                text: 'How To Take Your Pulse',
                Screen: Info3(),
              ),
              SizedBox(height: 20),
              BoxButton(
                image: 'assets/images/pulse1.png',
                color: Colors.lightBlue,
                text: 'Resting Heart Rate Chart',
                Screen: Info4(),
              ),
              SizedBox(height: 20),
              BoxButton(
                image: 'assets/images/heart1.png',
                color: Colors.greenAccent,
                text: 'Improve Your Resting Heart Rate',
                Screen: Info5(),
              ),
              SizedBox(height: 20),
              BoxButton(
                image: 'assets/images/stress.png',
                color: Colors.lightGreen,
                text: 'Top ways to reduce daily stress',
                Screen: Info6(),
              ),
              SizedBox(height: 20),
              BoxButton(
                image: 'assets/images/depression.png',
                color: Colors.green,
                text: 'Help Somebody with Mental Health Condition',
                Screen: Info7(),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
