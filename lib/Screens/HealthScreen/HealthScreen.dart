import 'package:flutter/material.dart';
import 'package:teledoctor_project/Components/BottomAppBar.dart';
import 'package:teledoctor_project/Screens/HealthScreen/-----/AddMedicines.dart';
import 'package:teledoctor_project/Screens/HealthScreen/-----/Diet.dart';
import 'package:teledoctor_project/Screens/HealthScreen/-----/TrackSleep.dart';

class HealthScreen extends StatefulWidget {
  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  int counter = 0;
  int _currentTipIndex = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  final List<String> _dailyTips = [
    'Stay hydrated! Drink at least 8 cups of water a day to maintain optimal health.',
    'Exercise regularly. Aim for at least 30 minutes of moderate physical activity every day.',
    'Eat a balanced diet rich in fruits, vegetables, and whole grains.',
    'Get enough sleep. Aim for 7-9 hours of sleep per night.',
    'Take regular breaks during work to rest and recharge.',
    'Practice mindfulness or meditation to reduce stress.',
    'Maintain social connections and spend time with loved ones.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            // Medicines and Water Intake Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/medicine.png',
                            height: 60,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Medicines',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (c) {
                                  return MedicineReminder();
                                }),
                              );
                            },
                            color: Colors.black45,
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/water.png',
                            height: 60,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Water Intake',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: decrementCounter,
                                icon: Icon(Icons.remove),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$counter',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              IconButton(
                                onPressed: incrementCounter,
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            // Diet Recipes and Track Sleep Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/recipe.png',
                            height: 60,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Diet Recipes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (c) {
                                  return Diet();
                                }),
                              );
                            },
                            color: Colors.black45,
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/sleep.png',
                            height: 60,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Sleep Tracker',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (c) {
                                  return SleepTracker();
                                }),
                              );
                            },
                            color: Colors.black45,
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            // Daily Tips Section
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.blueAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Tips',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _dailyTips[_currentTipIndex],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: _changeTip,
                    child: Text(
                      'Next Tip',
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BAB(),
    );
  }

  void _changeTip() {
    setState(() {
      _currentTipIndex = (_currentTipIndex + 1) % _dailyTips.length;
    });
  }
}

