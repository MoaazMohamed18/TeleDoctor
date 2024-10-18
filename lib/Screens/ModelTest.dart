import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDataScreen extends StatefulWidget {
  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  final _formKey = GlobalKey<FormState>();
  bool smoking = false;
  bool stroke = false;
  bool diffWalking = false;
  String sex = 'Male';
  String ageCategory = '18-24';
  bool diabetic = false;
  String genHealth = 'Excellent';
  bool kidneyDisease = false;

  void navigateToResultScreen(String prediction, String advice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PredictionResultScreen(
          prediction: prediction,
          advice: advice,
        ),
      ),
    );
  }

  Future<void> predictHeartAttackRisk() async {
    final url = 'http://127.0.0.1:5000';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'smoking': smoking ? 1.0 : 0.0,
        'stroke': stroke ? 1.0 : 0.0,
        'diffwalking': diffWalking ? 1.0 : 0.0,
        'sex': sex == 'Male' ? 1.0 : 0.0,
        'ageCategory': ageCategoryToDouble(ageCategory),
        'diabetic': diabetic ? 1.0 : 0.0,
        'genHealth': genHealthToDouble(genHealth),
        'kidneyDisease': kidneyDisease ? 1.0 : 0.0,
      }),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      String prediction = result['prediction'];
      String advice = getAdviceBasedOnPrediction(prediction);

      navigateToResultScreen(prediction, advice);
    } else {
      print('Failed to get prediction from server.');
    }
  }

  String getAdviceBasedOnPrediction(String prediction) {
    if (prediction == 'Low Risk') {
      return 'Your risk of heart disease is low. Maintain a healthy lifestyle!';
    } else {
      return 'Your risk of heart disease is high. Please consult a doctor immediately!';
    }
  }

  double ageCategoryToDouble(String ageCategory) {
    switch (ageCategory) {
      case '18-24':
        return 0.0;
      case '25-29':
        return 1.0;
      case '30-34':
        return 2.0;
      case '35-39':
        return 3.0;
      case '40-44':
        return 4.0;
      case '45-49':
        return 5.0;
      case '50-54':
        return 6.0;
      case '55-59':
        return 7.0;
      case '60-64':
        return 8.0;
      case '65-69':
        return 9.0;
      case '70-74':
        return 10.0;
      case '75-79':
        return 11.0;
      case '80 or older':
        return 12.0;
      default:
        return 0.0;
    }
  }

  double genHealthToDouble(String genHealth) {
    switch (genHealth) {
      case 'Excellent':
        return 0.0;
      case 'Very Good':
        return 1.0;
      case 'Good':
        return 2.0;
      case 'Fair':
        return 3.0;
      case 'Poor':
        return 4.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Attack Predictor'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Patient Details:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Checkbox(
                    value: smoking,
                    onChanged: (value) {
                      setState(() {
                        smoking = value!;
                      });
                    },
                  ),
                  Text('Smoking'),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Checkbox(
                    value: stroke,
                    onChanged: (value) {
                      setState(() {
                        stroke = value!;
                      });
                    },
                  ),
                  Text('Stroke'),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Checkbox(
                    value: diffWalking,
                    onChanged: (value) {
                      setState(() {
                        diffWalking = value!;
                      });
                    },
                  ),
                  Text('Difficulty Walking'),
                ],
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: sex,
                decoration: InputDecoration(labelText: 'Sex'),
                items: ['Male', 'Female'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    sex = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: ageCategory,
                decoration: InputDecoration(labelText: 'Age Category'),
                items: [
                  '18-24', '25-29', '30-34', '35-39', '40-44',
                  '45-49', '50-54', '55-59', '60-64', '65-69',
                  '70-74', '75-79', '80 or older'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    ageCategory = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Checkbox(
                    value: diabetic,
                    onChanged: (value) {
                      setState(() {
                        diabetic = value!;
                      });
                    },
                  ),
                  Text('Diabetic'),
                ],
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: genHealth,
                decoration: InputDecoration(labelText: 'General Health'),
                items: [
                  'Excellent', 'Very Good', 'Good', 'Fair', 'Poor'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    genHealth = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Checkbox(
                    value: kidneyDisease,
                    onChanged: (value) {
                      setState(() {
                        kidneyDisease = value!;
                      });
                    },
                  ),
                  Text('Kidney Disease'),
                ],
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      predictHeartAttackRisk();
                    }
                  },
                  child: Text('Predict Risk'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PredictionResultScreen extends StatelessWidget {
  final String prediction;
  final String advice;

  PredictionResultScreen({required this.prediction, required this.advice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediction Result'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prediction:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              prediction,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Advice:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              advice,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
