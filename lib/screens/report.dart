import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/screens/first_screens/second_screen.dart';
import 'package:ug_blood_donate/screens/home_screen.dart';
import 'package:ug_blood_donate/utils/firebase.dart';

class Report_Page extends StatefulWidget {
  const Report_Page({super.key});

  @override
  State<Report_Page> createState() => _Report_PageState();
}

class _Report_PageState extends State<Report_Page> {
  currentUserId() {
    print("${firebaseAuth.currentUser?.uid}");
    return firebaseAuth.currentUser?.uid;
  }

  String? fullname = "";
  String? location = "";
  String? bloodType = "";
  String? photoUrl = "";
  String? rbc1 = "";
  String? mvc2 = "";
  String? platelets3 = "";
  String? hospital4 = "";

  @override
  void initState() {
    super.initState();
     User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('report')
        .doc(currentUserId())
        .get()
        .then((value) {
      //print('hi user');
      if (value.exists) {
        setState(() {
          fullname = value.data()!["glucose"];
          location = value.data()!["cholesterol"];
          bloodType = value.data()!["bilirubin"];
          photoUrl = value.data()!["bloodtype"];
          rbc1 = value.data()!['RBC'];
          mvc2 = value.data()!['MVC'];
          platelets3 = value.data()!['Platelets'];
          hospital4 = value.data()!['hospital'];
        });
      }
    });
    var user = FirebaseAuth.instance.authStateChanges().listen((user) {
          if (user == null) {
             Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  Onboarding()),
  );

            // Navigator.of(context)
            //     .pushReplacement(ThisIsFadeRoute(Onboarding(), Onboarding()));
          } else {
            print('User is signed in!');
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>   MyHomeScreen(  currentUser: FirebaseAuth.instance.currentUser,)),
  );
           
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Icon(
                    Icons.navigate_before,
                    size: 30.0,
                  ),
                  title: Text(
                    '    Report',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.red,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Research Center',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                hospital4!.toUpperCase(),
                style: TextStyle(
                    color: Colors.blueGrey[700], fontWeight: FontWeight.bold),
              ),
              // Text(
              //   'Dhaka',
              //   style: TextStyle(
              //       color: Colors.blueGrey[700],
              //       fontWeight: FontWeight.bold),
              // ),
              Container(
                height: 150,
                padding: const EdgeInsets.all(25.0),
                child: Center(
                    child: Image.asset('assets/images/ugblood donate.png')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                verticalDirection: VerticalDirection.down,
                children: [
                  Expanded(
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20.0),
                        child: Column(
                          children: [
                            Text(
                              fullname! + '\nmmoI/L',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Glucose',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blueGrey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 20.0),
                        child: Column(
                          children: [
                            Text(
                              location! + ' mmoI/L',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Cholesterol',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.blueGrey[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20.0),
                        child: Column(
                          children: [
                            Text(
                              bloodType! + ' mmoI/L',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Bilirubin',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.blueGrey[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20.0),
                        child: Column(
                          children: [
                            Text(
                              rbc1! + ' \nmI/L',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '    RBC     ',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.blueGrey[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20.0),
                        child: Column(
                          children: [
                            Text(
                              mvc2! + '\nfl',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'MVC',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.blueGrey[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20.0),
                        child: Column(
                          children: [
                            Text(
                              platelets3! + '\n bL',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '  Platelets  ',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.blueGrey[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Builder(builder: (context) {
      //   return FloatingActionButton.extended(
      //     onPressed: (() {}),
      //     backgroundColor: Colors.red,
      //     label: const Text('My Report'),
      //   );
      // }),
    );
    ;
  }
}
