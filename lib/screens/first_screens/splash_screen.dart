import 'dart:async';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:ug_blood_donate/screens/first_screens/second_screen.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Onboarding())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.pink,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                      width: 200.0,
                      height: 200.0,
                      child: Image.asset(
                        'assets/images/Picture1.png',
                        color: Colors.white,
                      )),
                ),
                Container(
                  width: 400.0,
                  height: 100.0,
                  child: const Center(
                      child: Text(
                    'UgBlood Donate',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                )
              ],
            ),
          )),
    );
  }
}
