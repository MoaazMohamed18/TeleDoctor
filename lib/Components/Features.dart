import 'package:flutter/material.dart';

class Features extends StatelessWidget {

  final String label;
  final String value;
  final String assetPath;
  final String unit;
  final Color color;

  const Features({required this.label, required this.value, required this.assetPath, required this.unit, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(assetPath, height: 40, color: color),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            '$label: $value $unit',
            style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );;
  }
}

