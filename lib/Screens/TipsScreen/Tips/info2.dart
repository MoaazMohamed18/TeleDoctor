import 'package:flutter/material.dart';
import 'package:teledoctor_project/Components/TextBold.dart';
import 'package:teledoctor_project/Components/Textnormal.dart';

class Info2 extends StatefulWidget {
  const Info2({Key? key}) : super(key: key);

  @override
  State<Info2> createState() => _Info2State();
}

class _Info2State extends State<Info2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Risk factors'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              TextNormal(text: 'High blood pressure has many risk factors, including:',),
              SizedBox(height: 10,),
              TextBold(text: 'Age',),
              SizedBox(height: 10,),
              TextNormal(text: 'The risk of high blood pressure increases with age. Until about age 64, high blood pressure is more common in men. Women are more likely to develop high blood pressure after age 65.',),
              SizedBox(height: 10,),
              TextBold(text: 'Race',),
              SizedBox(height: 10,),
              TextNormal(text: 'High blood pressure is particularly common among Black people. It develops at an earlier age in Black people than it does in white people.',),
              SizedBox(height: 10,),
              TextBold(text: 'Family history',),
              SizedBox(height: 10,),
              TextNormal(text: 'You\'re more likely to develop high blood pressure if you have a parent or sibling with the condition.',),
              SizedBox(height: 10,),
              TextBold(text: 'Obesity or being overweight',),
              SizedBox(height: 10,),
              TextNormal(text: 'Excess weight causes changes in the blood vessels, the kidneys and other parts of the body. These changes often increase blood pressure. Being overweight or having obesity also raises the risk of heart disease and its risk factors, such as high cholesterol.',),
              SizedBox(height: 10,),
              TextBold(text: 'Lack of exercise',),
              SizedBox(height: 10,),
              TextNormal(text: 'Not exercising can cause weight gain. Increased weight raises the risk of high blood pressure. People who are inactive also tend to have higher heart rates.',),
              SizedBox(height: 10,),
              TextBold(text: 'Too much salt',),
              SizedBox(height: 10,),
              TextNormal(text: 'A lot of salt — also called sodium — in the body can cause the body to retain fluid. This increases blood pressure.',),
              SizedBox(height: 10,),
              TextBold(text: 'Stress',),
              SizedBox(height: 10,),
              TextNormal(text: 'High levels of stress can lead to a temporary increase in blood pressure. Stress-related habits such as eating more, using tobacco or drinking alcohol can lead to further increases in blood pressure.',),
              SizedBox(height: 10,),
              TextBold(text: 'Pregnancy',),
              SizedBox(height: 10,),
              TextNormal(text: 'Sometimes pregnancy causes high blood pressure.',),
              SizedBox(height: 40,),
              TextNormal(text: 'High blood pressure is most common in adults. But kids can have high blood pressure too. High blood pressure in children may be caused by problems with the kidneys or heart. But for a growing number of kids, high blood pressure is due to lifestyle habits such as an unhealthy diet and lack of exercise.',),
            ],
          ),
        ),
      ),
    );
  }
}
