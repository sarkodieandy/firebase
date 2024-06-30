import 'package:firebase/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import '../component/rounded_button.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = ''; // Initialize email variable
  String password = ''; // Initialize password variable

  // Function to handle login
  void _loginUser() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
        Navigator.pushNamed(context, ChatScreen.id);
      // Handle successful login (e.g., navigate to home screen)
      // You can replace this with your desired logic.
    } catch (e) {
      // Handle login failure (e.g., show an error message)
      print('Login failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: Image.asset('images/logo.png'),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  email = value; // Update email variable
                });
              },
              decoration: kTextfieldDecoration.copyWith(
                hintText: 'Email:',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  password = value; // Update password variable
                });
              },
              decoration: kTextfieldDecoration.copyWith(
                hintText: 'Password:',
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              title: 'Login',
              colour: Colors.blueAccent,
              onPressed: _loginUser, // Call login function
            ),
          ],
        ),
      ),
    );
  }
}
