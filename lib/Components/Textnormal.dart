import 'package:flutter/material.dart';

class TextNormal extends StatelessWidget {

  final text;

  TextNormal({this.text});


  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        fontSize: 20,
      ),);
  }
}
