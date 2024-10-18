import 'package:flutter/material.dart';
import 'package:teledoctor_project/Firebase/FireStore.dart';

class HeartRiskApp extends StatefulWidget {
  @override
  _HeartRiskAppState createState() => _HeartRiskAppState();
}

class _HeartRiskAppState extends State<HeartRiskApp> {
  final _formKey = GlobalKey<FormState>();
  FirestoreService _firestoreService = FirestoreService();

  int age = 0;
  String gender = 'Male';
  double heartRate = 0.0;
  double spo2 = 100.0;
  bool smoking = false;
  bool familyHistory = false;
  bool diabetes = false;
  bool obesity = false;
  bool exercise = false;

  void navigateToResultScreen(String prediction, String advice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PredictionResultScreen(
          heartRate: heartRate,
          prediction: prediction,
          advice: advice,
          age: age,
        ),
      ),
    );
  }

  void predictHeartAttackRisk() async {
    double riskScore = 0.0;

    if (gender == 'Male') riskScore += 5.0;
    if (smoking) riskScore += 20.0;
    if (familyHistory) riskScore += 25.0;
    if (diabetes) riskScore += 10.0;
    if (obesity) riskScore += 10.0;
    if (!exercise) riskScore += 5.0;
    if (heartRate < 55 || heartRate > 110) riskScore += 20.0;
    if (spo2 < 90.0) riskScore += 20.0;

    String prediction;
    String advice = '';

    if (riskScore > 60) {
      prediction = 'High Risk';
      advice =
      'You are at high risk of heart disease. Please consult a doctor and consider lifestyle changes such as quitting smoking, maintaining a healthy weight, and regular exercise.';
    } else if (riskScore >= 40) {
      prediction = 'Medium Risk';
      advice =
      'You are at medium risk of heart disease. Consider improving your lifestyle by quitting smoking, maintaining a healthy weight, and exercising regularly. Consult a doctor for personalized advice.';
    } else {
      prediction = 'Low Risk';
      advice =
      'You are at low risk of heart disease. Maintain your healthy habits, stay active, and continue regular health check-ups.';
    }

    if (smoking) {
      advice += '\n- Quit smoking to further reduce your risk of heart disease.';
    }
    if (diabetes) {
      advice +=
      '\n- Manage your diabetes through medication, diet, and regular exercise.';
    }
    if (obesity) {
      advice += '\n- Work on losing weight through a balanced diet and regular physical activity.';
    }
    if (!exercise) {
      advice += '\n- Incorporate regular exercise into your routine to improve your heart health.';
    }

    Map<String, dynamic> data = {
      'age': age,
      'gender': gender,
      'heartRate': heartRate,
      'spo2': spo2,
      'smoking': smoking,
      'familyHistory': familyHistory,
      'diabetes': diabetes,
      'obesity': obesity,
      'exercise': exercise,
      'prediction': prediction,
    };

    await _firestoreService.addData(data);

    navigateToResultScreen(prediction, advice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Attack Test'),
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
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Age', helperText: 'Age must be between 20-80'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  return null;
                },
                onSaved: (value) {
                  age = int.parse(value!);
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: gender,
                decoration: InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Heart Rate (BPM)', suffixText: 'BPM'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter heart rate';
                  }
                  return null;
                },
                onSaved: (value) {
                  heartRate = double.parse(value!);
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'SpO2 (%)', suffixText: '%'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter SpO2';
                  }
                  return null;
                },
                onSaved: (value) {
                  spo2 = double.parse(value!);
                },
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
              Row(
                children: [
                  Checkbox(
                    value: familyHistory,
                    onChanged: (value) {
                      setState(() {
                        familyHistory = value!;
                      });
                    },
                  ),
                  Text('Family History of Heart Disease'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: diabetes,
                    onChanged: (value) {
                      setState(() {
                        diabetes = value!;
                      });
                    },
                  ),
                  Text('Diabetes'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: obesity,
                    onChanged: (value) {
                      setState(() {
                        obesity = value!;
                      });
                    },
                  ),
                  Text('Obesity'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: exercise,
                    onChanged: (value) {
                      setState(() {
                        exercise = value!;
                      });
                    },
                  ),
                  Text('Regular Exercise'),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    predictHeartAttackRisk();
                  }
                },
                child: Text('Predict'),
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
  final int age;
  final double heartRate;


  PredictionResultScreen({
    required this.prediction,
    required this.advice,
    required this.age,
    required this.heartRate,

  });

  // String getTargetHeartRateMessage() {
  //   String zone = '';
  //   String message = '';
  //
  //   if (age >= 20) {
  //     zone = '100 to 170 bpm';
  //     if (heartRate < 100) {
  //       message = 'Your heart rate is below the target zone.\nIf you consistently have a heart rate below the target zone, it may indicate poor cardiovascular fitness or other health issues.';
  //     } else if (heartRate > 170) {
  //       message = 'Your heart rate is above the target zone.\nIf you consistently exceed the target heart rate zone during physical activity, it could be due to intense exercise, stress, or other factors.';
  //     }
  //   } else if (age <= 30) {
  //     zone = '95 to 162 bpm';
  //     if (heartRate < 95) {
  //       message = 'Your heart rate is below the target zone.\nIf you consistently have a heart rate below the target zone, it may indicate poor cardiovascular fitness or other health issues.';
  //     } else if (heartRate > 162) {
  //       message = 'Your heart rate is above the target zone.\nIf you consistently exceed the target heart rate zone during physical activity, it could be due to intense exercise, stress, or other factors.';
  //     }
  //   } else if (age <= 35) {
  //     zone = '93 to 157 bpm';
  //     if (heartRate < 93) {
  //       message = 'Your heart rate is below the target zone.\nIf you consistently have a heart rate below the target zone, it may indicate poor cardiovascular fitness or other health issues.';
  //     } else if (heartRate > 157) {
  //       message = 'Your heart rate is above the target zone.\nIf you consistently exceed the target heart rate zone during physical activity, it could be due to intense exercise, stress, or other factors.';
  //     }
  //   } else if (age <= 40) {
  //     zone = '90 to 153 bpm';
  //     if (heartRate < 90) {
  //       message = 'Your heart rate is below the target zone.\nIf you consistently have a heart rate below the target zone, it may indicate poor cardiovascular fitness or other health issues.';
  //     } else if (heartRate > 153) {
  //       message = 'Your heart rate is above the target zone.\nIf you consistently exceed the target heart rate zone during physical activity, it could be due to intense exercise, stress, or other factors.';
  //     }
  //   } else if (age <= 45) {
  //     zone = '88 to 149 bpm';
  //     if (heartRate < 88) {
  //       message = 'Your heart rate is below the target zone.\nIf you consistently have a heart rate below the target zone, it may indicate poor cardiovascular fitness or other health issues.';
  //     } else if (heartRate > 149) {
  //       message = 'Your heart rate is above the target zone.\nIf you consistently exceed the target heart rate zone during physical activity, it could be due to intense exercise, stress, or other factors.';
  //     }
  //   } else if (age <= 50) {
  //     zone = '85 to 145 bpm';
  //     if (heartRate < 85) {
  //       message = 'Your heart rate is below the target zone.\nIf you consistently have a heart rate below the target zone, it may indicate poor cardiovascular fitness or other health issues.';
  //     } else if (heartRate > 145) {
  //       message = 'Your heart rate is above the target zone.\nIf you consistently exceed the target heart rate zone during physical activity, it could be due to intense exercise, stress, or other factors.';
  //     }
  //   } else if (age <= 55) {
  //     zone = '83 to 140 bpm';
  //     if (heartRate < 83) {
  //       message = 'Your heart rate is below the target zone.\nIf you consistently have a heart rate below the target zone, it may indicate poor cardiovascular fitness or other health issues.';
  //     } else if (heartRate > 140) {
  //       message = 'Your heart rate is above the target zone.\nIf you consistently exceed the target heart rate zone during physical activity, it could be due to intense exercise, stress, or other factors.';
  //     }
  //   } else if (age <= 60) {
  //     zone = '80 to 136 bpm';
  //     if (heartRate < 80) {
  //       message = 'Your heart rate is below the target zone.\nIf you consistently have a heart rate below the target zone, it may indicate poor cardiovascular fitness or other health issues.';
  //     } else if (heartRate > 136) {
  //       message = 'Your heart rate is above the target zone.\nIf you consistently exceed the target heart rate zone during physical activity, it could be due to intense exercise, stress, or other factors.';
  //     }
  //   } else if (age <= 65) {
  //     zone = '78 to 132 bpm';
  //     if (heartRate < 78) {
  //       message = 'Your heart rate is below the target zone.\nIf you consistently have a heart rate below the target zone, it may indicate poor cardiovascular fitness or other health issues.';
  //     } else if (heartRate > 132) {
  //       message = 'Your heart rate is above the target zone.\nIf you consistently exceed the target heart rate zone during physical activity, it could be due to intense exercise, stress, or other factors.';
  //     }
  //   } else {
  //     zone = '75 to 128 bpm';
  //     if (heartRate < 75) {
  //       message = 'Your heart rate is below the target zone.\nIf you consistently have a heart rate below the target zone, it may indicate poor cardiovascular fitness or other health issues.';
  //     } else if (heartRate > 128) {
  //       message = 'Your heart rate is above the target zone.\nIf you consistently exceed the target heart rate zone during physical activity, it could be due to intense exercise, stress, or other factors.';
  //     }
  //   }
  //
  //   return 'Based on your age:\nTarget Heart Rate Zone: $zone\n\n$message';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate Result'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Result:',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  prediction,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Advice:',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  advice,
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(height: 16.0),
                // Text(
                //   getTargetHeartRateMessage(),
                //   style: TextStyle(fontSize: 16.0),
                //   textAlign: TextAlign.center,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
