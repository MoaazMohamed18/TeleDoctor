import 'package:flutter/material.dart';
import 'package:teledoctor_project/Components/TextBold.dart';
import 'package:teledoctor_project/Components/Textnormal.dart';

class Info3 extends StatefulWidget {
  const Info3({Key? key}) : super(key: key);

  @override
  State<Info3> createState() => _Info3State();
}

class _Info3State extends State<Info3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('How To Take Your Pulse'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Image.asset('assets/images/PulseCheck.png',
              ),
              TextNormal(text: "One simple thing people can do is to check their resting heart rate. It's a fairly easy to do, and having the information can help down the road. It's a good idea to take your pulse occasionally to get a sense of what's normal for you and to identify unusual changes in rate or regularity that may warrant medical attention."
              "\n\n- Although you may be able to feel your blood pumping in a number of places — your neck, the inside of your elbow, and even the top of your foot — your wrist is probably the most convenient and reliable place to get a good pulse."
                  "\n\n- Press your index and middle fingers together on your wrist, below the fat pad of your thumb."
              "\n\n- Feel around lightly until you detect throbbing. If you press too hard you may suppress the pulse."
              "\n\n- You can probably get a pretty accurate reading by counting the number of beats in 15 seconds and multiplying that number by four."
              "\n\n- The best time to get your resting heart rate is first thing in the morning, even before you get out of bed.",
              ),

            ],
          ),
        ),
      ),
    );
  }
}