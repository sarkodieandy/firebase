import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/constants.dart'; // Make sure to import your constants file
import 'package:firebase/screens/chat_screen.dart';
import '../component/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
 String email = ''; // Initialize email variable
  String password = ''; // Initialize password variable

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
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(height: 48.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
              onChanged: (value) {
                email = value;
              },
              decoration: kTextfieldDecoration.copyWith(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextfieldDecoration.copyWith(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 24.0),
            RoundedButton(
              title: 'Register',
              colour: Colors.blueAccent,
              onPressed: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  Navigator.pushNamed(context, ChatScreen.id);
                                } catch (e) {
                  print('Error during registration: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
