import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RealTimeDatabase extends StatelessWidget {
  RealTimeDatabase({super.key});
  final ref = FirebaseDatabase.instance.ref('myapp');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Real Time Database'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRow('Heart Rate', snapshot.child('HeartRate').value.toString(), 'assets/images/heart.png', 'BPM', Colors.red),
                          Divider(color: Colors.grey[300]),
                          _buildRow('Humidity', snapshot.child('Humidity').value.toString(), 'assets/images/humidity.png', '%', Colors.blue),
                          Divider(color: Colors.grey[300]),
                          _buildRow('SpO2', snapshot.child('SpO2').value.toString(), 'assets/images/spo2.png', '%', Colors.orange),
                          Divider(color: Colors.grey[300]),
                          _buildRow('Temperature', snapshot.child('Temperature').value.toString(), 'assets/images/celsius.png', '°C', Colors.green),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, String assetPath, String unit, Color color) {
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
    );
  }
}
