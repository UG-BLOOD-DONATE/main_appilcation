import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
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
                  child: Image.asset('assets/images/Picture1.png')
                ),
              ),
              Container(
                width: 400.0,
                height: 100.0,
                child: Center(child: Text('UgBlood Donate',
                 style: TextStyle(fontSize: 30,
                 color: Colors.white,
                  fontWeight: FontWeight.bold),
                 )),
               )
            ],
          ),
        )
      ),
    );
  }
}

