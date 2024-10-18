import 'package:flutter/material.dart';
import 'package:teledoctor_project/Components/Users.dart';
import 'package:teledoctor_project/Screens/HomeScreen/HomeScreen.dart';
import 'package:teledoctor_project/Screens/RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  void _login() {
    String emailValue = emailController.text.trim();
    String passwordValue = passwordController.text.trim();

    bool isRegistered = registeredUsersManager.isUserRegistered(emailValue, passwordValue);

    if (isRegistered) {
      print('Login successful!');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print('Login failed: Invalid email or password.');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid email or password'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Image.asset(
                  'assets/images/TeleDoc.png',
                  height: 200,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'E-mail',
                      hintText: 'Enter your email here',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter your password here',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                ),
                SizedBox(height: 20),
                MaterialButton(
                  onPressed: _login,
                  color: Colors.pinkAccent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                    child: Text(
                      'LOG IN',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.pinkAccent),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
