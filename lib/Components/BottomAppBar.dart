import 'package:flutter/material.dart';
import 'package:teledoctor_project/Screens/ChatScreen/------/DoctorSelect.dart';
import 'package:teledoctor_project/Screens/ChatScreen/ChatScreen.dart';
import 'package:teledoctor_project/Screens/HealthScreen/HealthScreen.dart';
import 'package:teledoctor_project/Screens/Home.dart';
import 'package:teledoctor_project/Screens/HomeScreen/HomeScreen.dart';
import 'package:teledoctor_project/Screens/TipsScreen/InformationScreen.dart';
import 'package:teledoctor_project/Screens/UserScreen/UserScreen.dart';

class BAB extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBottomNavigationBarItem(
              context,
              icon: Icons.home,
              label: 'Home',
              destination: HomeScreen(),
            ),
            _buildBottomNavigationBarItem(
              context,
              icon: Icons.chat_outlined,
              label: 'Chat',
              destination: DoctorSelectScreen(),
            ),
            _buildBottomNavigationBarItem(
              context,
              icon: Icons.health_and_safety,
              label: 'Health',
              destination: HealthScreen(),
            ),
            _buildBottomNavigationBarItem(
              context,
              icon: Icons.person,
              label: 'Profile',
              destination: UserScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Widget destination,
      }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (c) {
              return destination;
            }),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.blueAccent,
            ),
            Text(
              label,
              style: TextStyle(color: Colors.blueAccent, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
