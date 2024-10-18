import 'package:flutter/material.dart';
import 'package:teledoctor_project/Components/Textnormal.dart';

class Info7 extends StatefulWidget {
  const Info7({Key? key}) : super(key: key);

  @override
  State<Info7> createState() => _Info7State();
}

class _Info7State extends State<Info7> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Help Somebody with Mental Health Condition'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              TextNormal(text: 'First Things First - Get The Facts'
                  '\nLEARN MORE'
                  '\nGet woke! Find out more about depression, anxiety, and mental  health to help you better understand what your friend is going through.'

                  '\n\nNext - Be There'
                  '\nOften it’s not going to be the advice that you give your friend or loved one that makes the difference. But rather, just you being there when they need someone the most.'

                  '\n\nTALK'
                  '\nHelp your friend feel at ease in your presence'

                  '\n1. Calmness is Comforting'
                  '\nDon’t panic, you’ll only add on to theirs'

                  '\n\n2. Be Honest About Your Own Struggles'
                  '\nSometimes the best way to help someone open up is to say “me too”'

                  '\n\n3. Humour Helps'
                  '\nLaugh with them, not at them!'
                  '\n\n4. Have a Non-Judgemental Attitude'
                '\nCreate a safe space for your friend to open up'

                '\n\nLISTEN'
                '\n\n5. Listen and Empathise'
                '\nIf they feel like talking, ask them how they’re doing, what you can do and what they find helpful'

                '\n\n6. Take Their Feelings Seriously'
                '\nIf someone is suffering from symptoms of a mental illness, it isn’t possible for them to “snap out of it”, “cheer up” or “forget about it”. They can’t change how they feel by simply trying harder. Often, they need time, support, and professional help in order to make a full recovery'

                '\n\n7. Reassure your friend that things are going to be OK. And encourage them to get help or speak to someone'

                '\n\n8. Back Off If You Have To'
                '\nWhat they’re going through is sensitive, and they may not be ready to talk about it, or even visit a helping professional. But having someone who’s willing to listen and talk “anytime you’re ready” really helps'
                ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
