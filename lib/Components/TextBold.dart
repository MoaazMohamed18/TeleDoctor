import 'package:flutter/material.dart';

class TextBold extends StatelessWidget {

  final text;

  TextBold({this.text});


  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 35,
      ),);
  }
}
