import 'package:flutter/material.dart';
import 'package:teledoctor_project/Components/BottomAppBar.dart';
import 'package:teledoctor_project/Components/DoctorCard.dart';
import 'package:teledoctor_project/Components/DrList.dart';
import 'package:teledoctor_project/Screens/ChatScreen/ChatScreen.dart';

class Doctor {
  final String name;
  final String speciality;
  final ImageProvider image;

  Doctor(this.name, this.speciality, this.image);
}

class DoctorSelectScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: DoctorCard(
              image: images[index],
              name: names[index],
              speciality: specialities[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      doctorName: names[index],
                      doctorSpeciality: specialities[index],
                      doctorImage: images[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BAB(),
    );
  }
}
