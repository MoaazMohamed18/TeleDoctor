import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teledoctor_project/Components/Users.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController patientIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();
  TextEditingController diagnosisController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  void _register() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String patientID = patientIDController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String allergies = allergiesController.text.trim();
    String diagnosis = diagnosisController.text.trim();

    if (password == confirmPassword) {
      Map<String, String> newUser = {
        'name': name,
        'email': email,
        'patientID': patientID,
        'password': password,
        'allergies': allergies,
        'diagnosis': diagnosis,
      };

      // Add new user using RegisteredUsersManager
      registeredUsersManager.addUser(newUser);

      // Save user info to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
      await prefs.setString('email', email);
      await prefs.setString('allergies', allergies);
      await prefs.setString('diagnosis', diagnosis);

      // Navigate back to login screen
      Navigator.of(context).pop();
    } else {
      // Show error message if passwords do not match
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Passwords do not match'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/TeleDoc.png',
                height: 200,),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: patientIDController,
                decoration: InputDecoration(labelText: 'Patient ID'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_passwordVisible,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Re-enter Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_confirmPasswordVisible,
              ),
              TextField(
                controller: allergiesController,
                decoration: InputDecoration(labelText: 'Allergies'),
              ),
              TextField(
                controller: diagnosisController,
                decoration: InputDecoration(labelText: 'Diagnosis'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('SIGN UP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
