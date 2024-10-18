import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PulseOximeter extends StatefulWidget {
  const PulseOximeter({Key? key}) : super(key: key);

  @override
  State<PulseOximeter> createState() => _PulseOximeterState();
}

class _PulseOximeterState extends State<PulseOximeter> {
  final List<Map<String, dynamic>> _pulseOximeters = [];

  @override
  void initState() {
    super.initState();
    _loadPulseOximeters();
  }

  Future<void> _loadPulseOximeters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? pulseOximetersJson = prefs.getStringList('pulseOximeters');
    if (pulseOximetersJson != null) {
      setState(() {
        _pulseOximeters.addAll(
            pulseOximetersJson.map((json) => Map<String, dynamic>.from(jsonDecode(json))));
      });
    }
  }

  Future<void> _addPulseOximeter() async {
    final int? newOximeter = await showDialog<int?>(
      context: context,
      builder: (BuildContext context) {
        int? inputOximeter;
        return AlertDialog(
          title: const Text('Enter your Pulse Oximeter (%)'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              inputOximeter = int.tryParse(value);
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
                Navigator.of(context).pop(inputOximeter);
              },
            ),
          ],
        );
      },
    );

    if (newOximeter != null) {
      DateTime now = DateTime.now();
      String formattedDateTime = DateFormat('yyyy-MM-dd – kk:mm').format(now);
      Map<String, dynamic> newPulseOximeter = {'oximeter': newOximeter, 'time': formattedDateTime};
      setState(() {
        _pulseOximeters.add(newPulseOximeter);
      });
      _savePulseOximeters();

      // Return the new oximeter value to the HomeScreen
      Navigator.of(context).pop(newOximeter);
    }
  }

  Future<void> _deletePulseOximeter(int index) async {
    setState(() {
      _pulseOximeters.removeAt(index);
    });
    _savePulseOximeters();
  }

  Future<void> _savePulseOximeters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> pulseOximetersJson =
    _pulseOximeters.map((pulseOximeter) => jsonEncode(pulseOximeter)).toList();
    await prefs.setStringList('pulseOximeters', pulseOximetersJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pulse Oximeter Measurements'),
        actions: [
          ElevatedButton(
            onPressed: _addPulseOximeter,
            child: const Icon(Icons.add,color: Colors.black,),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _pulseOximeters.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Pulse Oximeter: ${_pulseOximeters[index]['oximeter']} %',style: TextStyle(color: Colors.black)),
            subtitle: Text('Date & Time: ${_pulseOximeters[index]['time']}',style: TextStyle(color: Colors.black)),
            trailing: IconButton(
              icon: Icon(Icons.delete,color: Colors.black,),
              onPressed: () => _deletePulseOximeter(index),
            ),
          );
        },
      ),
    );
  }
}
