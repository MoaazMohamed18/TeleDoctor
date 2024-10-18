import 'package:flutter/material.dart';
import 'package:teledoctor_project/Components/Textnormal.dart';

class Info4 extends StatefulWidget {
  const Info4({Key? key}) : super(key: key);

  @override
  State<Info4> createState() => _Info4State();
}

class _Info4State extends State<Info4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Resting Heart Rate Chart'),
      ),
      body: InteractiveViewer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Image.asset('assets/images/heartchart.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
