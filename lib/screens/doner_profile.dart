// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.navigate_before_sharp,
          color: Colors.black,
          size: 24.0,
        ),
        title: const Text("Find Donors"),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: new ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 90.0),
                  child: Card(
                    child: Image.asset(
                      'lib/images/ntanda.jpg',
                      width: 200,
                      height: 150,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                /*1*/
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*2*/
                    Container(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: const Text(
                        'Yiga Gilbert',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
              /*3*/
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: Colors.pink),
              const Text("Wakiso, Uganda")
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                children: <Widget>[
                  new Positioned(
                      child: new Image.asset(
                    'lib/images/iconsase.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.fitWidth,
                  )),
                  Positioned(
                      child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      // ignore: prefer_const_constructors
                      Text(
                        "6",
                        style: new TextStyle(
                          color: Colors.pink,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        " Times donated",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )
                    ],
                  )),
                ],
              ),
              SizedBox(
                width: 60,
              ),
              Column(
                children: <Widget>[
                  new Positioned(
                      child: new Image.asset(
                    'lib/images/icon.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.fitWidth,
                  )),
                  Positioned(
                      child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      // ignore: prefer_const_constructors
                      Text(
                        "Blood Type",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        " AB+",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 20,
                        ),
                      )
                    ],
                  )),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                /*1*/
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.contact_phone,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            label: const Text('Call Now'),
                            onPressed: () {
                              print('Pressed');
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(150, 27, 158, 163)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ))),
                  ],
                ),
              ),
              Expanded(
                /*1*/
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.navigate_before_sharp,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            label: const Text('Request'),
                            onPressed: () {
                              print('Pressed');
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 233, 10, 103)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ))),
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.zero,
                  child: new Image.asset(
                    'lib/images/map.jpg',
                    width: 600,
                    height: 250,
                    fit: BoxFit.fitWidth,
                  )),
              Positioned(
                right: 12,
                bottom: 20,
                child: new FloatingActionButton(
                  child: const Icon(
                    Icons.directions_rounded,
                    size: 50.0,
                  ),
                  backgroundColor: Colors.pink,
                  onPressed: () {},
                ),
              ),
              Positioned(
                right: 195,
                bottom: 150,
                child: new FloatingActionButton(
                  child: const Icon(
                    Icons.location_on_rounded,
                    size: 25.0,
                  ),
                  backgroundColor: Colors.pink,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
