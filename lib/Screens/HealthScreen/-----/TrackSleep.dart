import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SleepTracker extends StatefulWidget {
  const SleepTracker({Key? key}) : super(key: key);

  @override
  _SleepTrackerState createState() => _SleepTrackerState();
}

class _SleepTrackerState extends State<SleepTracker> {
  DateTime? _sleepTime;
  DateTime? _wakeTime;

  @override
  void initState() {
    super.initState();
    _loadSleepData();
  }

  void _loadSleepData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? sleepTime = prefs.getString('sleepTime');
    final String? wakeTime = prefs.getString('wakeTime');

    setState(() {
      _sleepTime = sleepTime != null ? DateTime.parse(sleepTime) : null;
      _wakeTime = wakeTime != null ? DateTime.parse(wakeTime) : null;
    });
  }

  void _saveSleepData() async {
    final prefs = await SharedPreferences.getInstance();
    if (_sleepTime != null) {
      await prefs.setString('sleepTime', _sleepTime!.toIso8601String());
    }
    if (_wakeTime != null) {
      await prefs.setString('wakeTime', _wakeTime!.toIso8601String());
    }
  }

  Duration? get _sleepDuration {
    if (_sleepTime != null && _wakeTime != null) {
      return _wakeTime!.difference(_sleepTime!);
    }
    return null;
  }

  Future<void> _pickSleepTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _sleepTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          time.hour,
          time.minute,
        );
        _saveSleepData();
      });
    }
  }

  Future<void> _pickWakeTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      final now = DateTime.now();
      final wakeDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      if (wakeDateTime.isBefore(_sleepTime ?? DateTime.now())) {
        setState(() {
          _wakeTime = wakeDateTime.add(Duration(days: 1));
          _saveSleepData();
        });
      } else {
        setState(() {
          _wakeTime = wakeDateTime;
          _saveSleepData();
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sleep Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickSleepTime,
              child: Text('Set Sleep Time',style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: _pickWakeTime,
              child: Text('Set Wake Time',style: TextStyle(color: Colors.black)),
            ),
            if (_sleepDuration != null)
              Text('You slept for ${_sleepDuration!.inHours} hours and ${_sleepDuration!.inMinutes % 60} minutes',
                  style: TextStyle(fontSize: 17,color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}
