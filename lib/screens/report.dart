import 'package:donation_app/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(report_Page());
}

class report_Page extends StatelessWidget {
  const report_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                
                children: [
                  Card(
                    child: Container(
                      color: Colors.white70,
                      child: Icon(
                    Icons.navigate_before,
                    size: 50.0,
                  ),
                    ),
                  ),
                  SizedBox(
                    width: 120.0,
                  ),
                  Text(
                    'Report',
                    style: TextStyle(
                      fontSize: 40.0, fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.0,),
              Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,size: 30,
                        ),
                        SizedBox(width: 10.0,),
                        Text(
                          'Research Center',
                          style: TextStyle(
                            fontSize: 20.0,fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Makerere Medical College,',
                    style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    'Dhaka',
                    style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.bold
                      ),
                  ),
                  Container(
                    padding: EdgeInsets.all(25.0),
                    child: Center(child: Image.asset('images/cubes.png')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20.0),
                          child: Column(
                            children: [
                              Text(
                                '6 mmoI/L',
                                style: TextStyle(
                                  fontSize: 20.0,fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Glucose',
                                style: TextStyle(
                                  fontSize: 20.0,color: Colors.blueGrey[700],

                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
                          child: Column(
                            children: [
                              Text(
                                '6.2 mmoI/L',
                                style: TextStyle(
                                  fontSize: 20.0,fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Cholesterol',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.blueGrey[700]
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20.0),
                          child: Column(
                            children: [
                              Text(
                                '12 mmoI/L',
                                style: TextStyle(
                                  fontSize: 20.0,fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Bilirubin',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.blueGrey[700]
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20.0),
                          child: Column(
                            children: [
                              Text(
                                '3.6 mI/L',
                                style: TextStyle(
                                  fontSize: 20.0,fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '    RBC     ',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.blueGrey[700]
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20.0),
                          child: Column(
                            children: [
                              Text(
                                '102 fl',
                                style: TextStyle(
                                  fontSize: 20.0,fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '       MVC     ',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.blueGrey[700]
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20.0),
                          child: Column(
                            children: [
                              Text(
                                '276 bL',
                                style: TextStyle(
                                  fontSize: 20.0,fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '  Platelets  ',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.blueGrey[700]
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
            ],
          ),
        ),
        bottomNavigationBar:  Builder(
          builder: (context) {
            return FloatingActionButton.extended(
              onPressed: (() {
                
              }),
              backgroundColor: Colors.red,
              label: Text('My Report'),
            );
          }
        ),
      ),
    );
  }
}
