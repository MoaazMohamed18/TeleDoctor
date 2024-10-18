import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teledoctor_project/Components/BottomAppBar.dart';
import 'package:teledoctor_project/Firebase/RealTimeDatabase.dart';
import 'package:teledoctor_project/Screens/FireScreen.dart';
import 'package:teledoctor_project/Screens/HomeScreen/----/HeartRate.dart';
import 'package:teledoctor_project/Screens/HomeScreen/----/HeatIndex.dart';
import 'package:teledoctor_project/Screens/HomeScreen/----/MentalHealth.dart';
import 'package:teledoctor_project/Screens/HomeScreen/----/Oximeter.dart';
import 'package:teledoctor_project/Screens/TipsScreen/InformationScreen.dart';
import 'package:teledoctor_project/Screens/TipsScreen/Tips/info1.dart';
import 'package:teledoctor_project/Screens/TipsScreen/Tips/info2.dart';
import 'package:teledoctor_project/Screens/TipsScreen/Tips/info3.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _name = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi $_name!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset('assets/images/TeleDoc.png',
                    height: 60,),
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Let's check your health today",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available call with doctor \nin 24 Hours',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Image.asset('assets/images/doctor3.png',height: 120),
                  ],
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFeatureButton(
                      context,
                      'Measure',
                      'assets/images/Oxi.png',
                      RealTimeDatabase(),
                    ),
                    SizedBox(width: 8),
                    _buildFeatureButton(
                      context,
                      'Mental Health',
                      'assets/images/mental.png',
                      MentalHealth(),
                    ),
                    SizedBox(width: 8),
                    _buildFeatureButton(
                      context,
                      'Heart Attack\nTest',
                      'assets/images/attack.png',
                      HeartRiskApp(),
                    ),
                    SizedBox(width: 8),
                    _buildFeatureButton(
                      context,
                      'Heat Index\nCalculator',
                      'assets/images/sun.png',
                      HeatIndexCalculator(),
                    ),
                    SizedBox(width: 8),
                    _buildFeatureButton(
                      context,
                      'Heart Rate',
                      'assets/images/heart.png',
                      HeartRate(),
                    ),
                    SizedBox(width: 8),
                    _buildFeatureButton(
                      context,
                      'Oximeter',
                      'assets/images/oximeter.png',
                      PulseOximeter(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              _buildTopArticlesSection(),
              SizedBox(height: 16),
              _buildArticle(
                  title: "Understanding Blood Pressure Readings",
                  imagePath: 'assets/images/bloodpr.png',
                  screen: Info1()
              ),
              SizedBox(height: 8),
              _buildArticle(
                  title: 'Risk Factors of Blood Pressue',
                  imagePath: 'assets/images/highp.png',
                  screen: Info2()
              ),
              _buildArticle(
                  title: 'How To Take Your Pulse',
                  imagePath: 'assets/images/pulse.png',
                  screen: Info3()
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
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white.withOpacity(0.1),
            child: Center(
              child: Image.asset(
                assetPath,
                color: Colors.blueAccent,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopArticlesSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Top Articles',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {Navigator.of(context).push(
            MaterialPageRoute(builder: (c) => InformationScreen()),
          );},
          child: Text(
            'See all',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildArticle({required String title, required String imagePath, required Widget screen}) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (c) => screen),
        );
      },
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
