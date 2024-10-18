import 'package:flutter/material.dart';
import 'package:teledoctor_project/Components/DoctorCard.dart';
import 'package:teledoctor_project/Components/DrList.dart';
import 'package:teledoctor_project/Screens/UserScreen/----/Appointment.dart';

class DoctorListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Choose a Doctor'),
      ),
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
                    builder: (context) => Appointment(
                      index,
                      doctorImage: images[index], // Pass the corresponding image here
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
