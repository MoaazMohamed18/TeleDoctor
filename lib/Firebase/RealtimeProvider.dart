import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RealTimeDataProvider with ChangeNotifier {
  final DatabaseReference ref = FirebaseDatabase.instance.ref('myapp');

  double heartRate = 0.0;
  double humidity = 0.0;
  double spo2 = 0.0;
  double temperature = 0.0;

  RealTimeDataProvider() {
    ref.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      heartRate = double.parse(data['HeartRate'].toString());
      humidity = double.parse(data['Humidity'].toString());
      spo2 = double.parse(data['SpO2'].toString());
      temperature = double.parse(data['Temperature'].toString());
      notifyListeners();
    });
  }
}
