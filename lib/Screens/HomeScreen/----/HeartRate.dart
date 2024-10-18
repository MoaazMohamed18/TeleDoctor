import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeartRate extends StatefulWidget {
  const HeartRate({Key? key}) : super(key: key);

  @override
  State<HeartRate> createState() => _HeartRateState();
}

class _HeartRateState extends State<HeartRate> {
  final List<Map<String, dynamic>> _heartRates = [];

  @override
  void initState() {
    super.initState();
    _loadHeartRates();
  }

  Future<void> _loadHeartRates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? heartRatesJson = prefs.getStringList('heartRates');
    if (heartRatesJson != null) {
      setState(() {
        _heartRates.addAll(heartRatesJson.map((json) => Map<String, dynamic>.from(jsonDecode(json))));
      });
    }
  }

  Future<void> _addHeartRate(int newRate) async {
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    Map<String, dynamic> newHeartRate = {'rate': newRate, 'time': formattedDateTime};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _heartRates.add(newHeartRate);
      prefs.setStringList('heartRates', _heartRates.map((heartRate) => jsonEncode(heartRate)).toList());
      prefs.setString('latestHeartRate', newRate.toString());
    });
  }

  Future<void> _deleteHeartRate(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _heartRates.removeAt(index);
      prefs.setStringList('heartRates', _heartRates.map((heartRate) => jsonEncode(heartRate)).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Heart Rate Measurements'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final int? newRate = await showDialog<int>(
                context: context,
                builder: (BuildContext context) {
                  int? inputRate;
                  return AlertDialog(
                    title: const Text('Enter your heart rate'),
                    content: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        inputRate = int.tryParse(value);
                      },
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {
                          Navigator.of(context).pop(inputRate);
                        },
                      ),
                    ],
                  );
                },
              );
              if (newRate != null) {
                _addHeartRate(newRate);
              }
            },
            child: const Icon(Icons.add,color: Colors.black,),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _heartRates.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Heart Rate: ${_heartRates[index]['rate']} BPM',style: TextStyle(color: Colors.black),),
            subtitle: Text('Date & Time: ${_heartRates[index]['time']}',style: TextStyle(color: Colors.black),),
            trailing: IconButton(
              icon: Icon(Icons.delete,color: Colors.black),
              onPressed: () => _deleteHeartRate(index),
            ),
          );
        },
      ),
    );
  }
}
