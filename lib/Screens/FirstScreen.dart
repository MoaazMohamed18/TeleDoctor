import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bbb.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 40),
          child: MaterialButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (c){
                  return LoginScreen();
                })
            );
          },
          color: Colors.indigo,
            height: 50,
            minWidth: 250,
            child: Text('Get Started',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ),

    );
  }
}
