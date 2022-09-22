import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/home.dart';
import 'package:ug_blood_donate/screens/first_screens/LoginRegister.dart';
import 'package:ug_blood_donate/screens/first_screens/third_sreen.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late StreamSubscription<User?> user;
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(
              currentUser: user,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 90.0),
                  child: Center(child: Image.asset('assets/images/Vector.png')),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    'Find Blood Donors',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Locate a blood donor nearby',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                    Text(
                      'and contact them to help you',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                    Text(
                      'incase of an emergency',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Frist_Home(),
                              ),
                            ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          "Skip",
                          style: TextStyle(color: Colors.black),
                        )),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Onboarding2(),
                        ),
                      ),
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.green),
                      child: Text("Next"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
