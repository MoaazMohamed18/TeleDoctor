import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teledoctor_project/Components/BottomAppBar.dart';
import 'package:teledoctor_project/Screens/FirstScreen.dart';
import 'package:teledoctor_project/Screens/LoginScreen.dart';
import 'package:teledoctor_project/Screens/SplashScreen.dart';
import 'package:teledoctor_project/Screens/UserScreen/----/Doctors.dart';
import 'package:teledoctor_project/Screens/UserScreen/----/EditAccount.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String _name = '';
  String _email = '';
  String _diagnosis = '';
  String _allergies = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
      _email = prefs.getString('email') ?? '';
      _diagnosis = prefs.getString('diagnosis') ?? '';
      _allergies = prefs.getString('allergies') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/Doctor.jpg'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    '     $_name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) {
                        return EditAccount();
                      }),
                    );
                    _loadUserData();
                  },
                ),
              ],
            ),
            Text(
              _email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Patient ID: 123456',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 16),
            Text(
              'Diagnosis: $_diagnosis',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 16),
            Text(
              'Allergies: $_allergies',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 24),
            MaterialButton(
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) {
                    return DoctorListScreen();
                  }),
                );
              },
              child: Text('Schedule Appointment'),
            ),
            IconButton(
              icon: Icon(Icons.logout,
                color: Colors.blueAccent,
                size: 30,),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) {
                    return SplashScreen();
                  }),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BAB(),
    );
  }
}
