import 'package:flutter/material.dart';
import 'package:teledoctor_project/Components/TextBold.dart';
import 'package:teledoctor_project/Components/Textnormal.dart';

class Info5 extends StatefulWidget {
  const Info5({Key? key}) : super(key: key);

  @override
  State<Info5> createState() => _Info5State();
}

class _Info5State extends State<Info5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('Resting Heart Rate'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              TextBold(text: "How to lower your resting heart rate"),
              TextNormal(text: "\nBy doing these four things you can start to lower your resting heart rate and also help maintain a healthy heart:"
"                \n\n1- Exercise more: When you take a brisk walk, swim, or bicycle, your heart beats faster during the activity and for a short time afterward. But exercising every day gradually slows the resting heart rate."
"                \n\n2- Reduce stress: Performing the relaxation response, meditation, tai chi, and other stress-busting techniques lowers the resting heart rate over time."
"                \n\n3- Avoid tobacco products: Smokers have higher resting heart rates. Quitting brings it back down."
"                \n\n4- Lose weight if necessary: The larger the body, the more the heart must work to supply it with blood. Losing weight can help slow an elevated resting heart rate."
              ),
              TextBold(text: '\nWhen to see a doctor'),
              TextNormal(text: "\nIf your resting heart rate is consistently above 85 beats per minute, mention it to your doctor. While it may be normal for you, it's good to consider how your heart rate and other personal factors may be influencing your overall health, including your risk of cardiovascular disease."
              ),
            ],
          ),
        ),
      ),
    );
  }
}
