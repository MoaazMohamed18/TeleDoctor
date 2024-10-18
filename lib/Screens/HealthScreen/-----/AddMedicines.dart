import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'package:shared_preferences/shared_preferences.dart';

class MedicineReminder extends StatefulWidget {
  const MedicineReminder({Key? key}) : super(key: key);

  @override
  State<MedicineReminder> createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  final List<Map<String, dynamic>> _medicines = [];

  @override
  void initState() {
    super.initState();
    _loadMedicines();
  }

  Future<void> _loadMedicines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? medicinesJson = prefs.getStringList('medicines');
    if (medicinesJson != null) {
      setState(() {
        _medicines.addAll(medicinesJson.map((json) => jsonDecode(json)));
      });
    }
  }

  Future<void> _addMedicine(String name, TimeOfDay time) async {
    String formattedTime = DateFormat.Hm().format(DateTime(2024, 1, 1, time.hour, time.minute));
    Map<String, dynamic> newMedicine = {
      'name': name,
      'time': formattedTime,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _medicines.add(newMedicine);
      prefs.setStringList('medicines', _medicines.map((medicine) => jsonEncode(medicine)).toList());
    });
  }

  Future<void> _deleteMedicine(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _medicines.removeAt(index);
      prefs.setStringList('medicines', _medicines.map((medicine) => jsonEncode(medicine)).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Medicine Reminder'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final Map<String, dynamic>? newMedicine = await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (BuildContext context) {
                  String name = '';
                  TimeOfDay time = TimeOfDay.now();

                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        title: const Text('Add new medicine'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              onChanged: (value) {
                                name = value;
                              },
                              decoration: const InputDecoration(hintText: 'Medicine Name'),
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: time,
                                );
                                if (pickedTime != null) {
                                  setState(() {
                                    time = pickedTime;
                                  });
                                }
                              },
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  hintText: 'Time (HH:mm)',
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('${time.format(context)}'), // Display formatted time
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
                              if (name.isNotEmpty) {
                                Navigator.of(context).pop({
                                  'name': name,
                                  'time': time,
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please enter a medicine name.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );

              if (newMedicine != null) {
                _addMedicine(newMedicine['name'], newMedicine['time']);
              }
            },
            child: const Icon(Icons.add,color: Colors.black,),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _medicines.length,
        itemBuilder: (BuildContext context, int index) {
          String name = _medicines[index]['name'];
          String time = _medicines[index]['time'];
          return ListTile(
            title: Text('$name',style: TextStyle(color: Colors.black)),
            subtitle: Text('Time: $time',style: TextStyle(color: Colors.black)),
            trailing: IconButton(
              icon: Icon(Icons.delete,color: Colors.black),
              onPressed: () => _deleteMedicine(index),
            ),
          );
        },
      ),
    );
  }
}
