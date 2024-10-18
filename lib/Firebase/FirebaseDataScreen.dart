import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDataScreen extends StatefulWidget {
  @override
  _FirebaseDataScreenState createState() => _FirebaseDataScreenState();
}

class _FirebaseDataScreenState extends State<FirebaseDataScreen> {
  late DatabaseReference _database;
  String _data = 'Loading...';

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();

    FirebaseApp secondaryApp = await Firebase.initializeApp(
      name: 'SecondaryApp',
      options: FirebaseOptions(
        apiKey: 'AIzaSyDcK-bfKFFnuoJRUW8eJkX7ib1bOpIZ3Gc',
        appId: '1:1021120801088:android:df6dafffea655c87f2b2a5',
        messagingSenderId: '1021120801088',
        projectId: 'teledoctor-d57e8',
        databaseURL: 'https://teledoctor-d57e8-default-rtdb.firebaseio.com/',
      ),
    );

    FirebaseDatabase database = FirebaseDatabase.instanceFor(app: secondaryApp);
    _database = database.reference().child('message');

    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(app: firebaseApp,
        databaseURL: 'https://teledoctor-d57e8-default-rtdb.firebaseio.com/');

    _fetchDataFromFirebase();
  }

  void _fetchDataFromFirebase() {
    _database.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          _data = event.snapshot.value.toString();
        });
      } else {
        setState(() {
          _data = 'No data available';
        });
      }
    }, onError: (error) {
      setState(() {
        _data = 'Error fetching data: $error';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Database Demo'),
      ),
      body: Center(
        child: Text(_data),
      ),
    );
  }
}
