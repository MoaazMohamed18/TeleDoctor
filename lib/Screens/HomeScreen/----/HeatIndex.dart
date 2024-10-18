import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

class HeatIndexCalculator extends StatefulWidget {
  @override
  _HeatIndexCalculatorState createState() => _HeatIndexCalculatorState();
}

class _HeatIndexCalculatorState extends State<HeatIndexCalculator> {
  final _formKey = GlobalKey<FormState>();
  double temperature = 0.0;
  double humidity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heat Index Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Temperature (°C)', suffixText: '°C'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter temperature';
                  }
                  return null;
                },
                onSaved: (value) {
                  temperature = double.parse(value!);
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Humidity (%)', suffixText: '%'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter humidity';
                  }
                  return null;
                },
                onSaved: (value) {
                  humidity = double.parse(value!);
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    String advice = getWeatherMessage();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Weather Advice'),
                          content: Text(advice),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Calculate Heat Index'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getWeatherMessage() {
    if (temperature == 0.0 || humidity == 0.0) {
      return 'Enter temperature and humidity to calculate heat index.';
    }

    double tempFahrenheit = temperature * 9 / 5 + 32;

    double heatIndex = -42.379 +
        2.04901523 * tempFahrenheit +
        10.14333127 * humidity -
        0.22475541 * tempFahrenheit * humidity -
        6.83783 * pow(10, -3) * tempFahrenheit * tempFahrenheit -
        5.481717 * pow(10, -2) * humidity * humidity +
        1.22874 * pow(10, -3) * tempFahrenheit * tempFahrenheit * humidity +
        8.5282 * pow(10, -4) * tempFahrenheit * humidity * humidity -
        1.99 * pow(10, -6) * tempFahrenheit * tempFahrenheit * humidity * humidity;

    String riskLevel = '';

    if (heatIndex > 130) {
      riskLevel = 'Extreme danger: heat stroke is imminent. Avoid outdoor activities.';
    } else if (heatIndex >= 105 && heatIndex <= 130) {
      riskLevel = 'Danger: heat cramps and heat exhaustion are likely; heat stroke is probable with continued activity. Minimize outdoor exertion.';
    } else if (heatIndex >= 90 && heatIndex < 105) {
      riskLevel = 'Extreme caution: heat cramps and heat exhaustion are possible. Limit outdoor activities during peak sun hours.';
    } else if (heatIndex >= 70 && heatIndex < 90) {
      riskLevel = 'Caution: fatigue is possible with prolonged exposure and activity. Stay hydrated and take breaks.';
    } else {
      riskLevel = 'No significant risk. Enjoy outdoor activities safely.';
    }

    return riskLevel;
  }
}