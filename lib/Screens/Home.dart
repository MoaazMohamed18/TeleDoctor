import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:teledoctor_project/Components/BottomAppBar.dart';
import 'package:teledoctor_project/Components/Drawer.dart';
import 'package:teledoctor_project/Firebase/RealTimeDatabase.dart';
import 'package:teledoctor_project/Screens/HomeScreen/----/HeartRate.dart';
import 'package:teledoctor_project/Screens/HomeScreen/----/MentalHealth.dart';
import 'package:teledoctor_project/Screens/HomeScreen/----/Oximeter.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  int _currentTipIndex = 0;
  List<Map<String, dynamic>> _medicines = [];
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadMedicines();
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

  void _changeTip() {
    setState(() {
      _currentTipIndex = (_currentTipIndex + 1) % _dailyTips.length;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '17°C',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.cloud,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.black54),
                        prefixIcon: Icon(Icons.search, color: Colors.black54),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  _buildFeatureButton(
                    context,
                    'Measure',
                    'assets/images/measure.png',
                    RealTimeDatabase(),
                  ),
                  _buildFeatureButton(
                    context,
                    'Heart Rate',
                    'assets/images/heart-rate.png',
                    HeartRate(),
                  ),
                  _buildFeatureButton(
                    context,
                    'Oximeter',
                    'assets/images/pulse-oximeter.png',
                    PulseOximeter(),
                  ),
                  _buildFeatureButton(
                    context,
                    'Mental Health',
                    'assets/images/psychology.png',
                    MentalHealth(),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                height: 150,
                child: PageView(
                  controller: _pageController,
                  children: [
                    GestureDetector(
                      onTap: _changeTip,
                      child: _buildDailyTip(),
                    ),
                    _buildReminders(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SmoothPageIndicator(
                controller: _pageController,
                count: 2,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BAB(),
    );
  }

  Widget _buildFeatureButton(BuildContext context, String label, String assetPath, Widget screen) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (c) => screen),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        height: 100,
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(assetPath, height: 80, width: 80),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyTip() {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Health Tip',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            _dailyTips[_currentTipIndex],
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminders() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reminders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _medicines.length,
              itemBuilder: (BuildContext context, int index) {
                String name = _medicines[index]['name'];
                String time = _medicines[index]['time'];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    'You should take ($name) at ($time)',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}