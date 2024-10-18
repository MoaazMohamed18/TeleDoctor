import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _diagnosisController;
  late TextEditingController _allergiesController;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController = TextEditingController(text: prefs.getString('name') ?? '');
      _emailController = TextEditingController(text: prefs.getString('email') ?? '');
      _diagnosisController = TextEditingController(text: prefs.getString('diagnosis') ?? '');
      _allergiesController = TextEditingController(text: prefs.getString('allergies') ?? '');
    });
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('diagnosis', _diagnosisController.text);
    await prefs.setString('allergies', _allergiesController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Account'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _saveUserData();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _diagnosisController,
                decoration: InputDecoration(labelText: 'Diagnosis'),
              ),
              TextFormField(
                controller: _allergiesController,
                decoration: InputDecoration(labelText: 'Allergies'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
