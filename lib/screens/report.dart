import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  CollectionReference report = FirebaseFirestore.instance.collection('report');
  var glucose;
  var cholesterol;
  var bilirubin;
  var bloodtype;
  var rbc;
  var mvc;
  var platelets;
  var hospital;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: report.doc(currentUserId()).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          glucose = data['glucose'];
          cholesterol = data['cholesterol'];
          bilirubin = data['bilirubin'];
          bloodtype = data['bloodtype'];
          rbc = data['rbc'];
          mvc = data['mvc'];
          platelets = data['platelets'];
          hospital = data['hospital'];

          // name = data['fullname'];
          // blood = data['bloodType'];
          // loc = data['location'];
          // pic = data['photoURL'];
          // num = data['phonenumber'];
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            // name = data['fullname'];
            // blood = data['bloodType'];
            // loc = data['location'];
            // pic = data['photoURL'];
            // num = data['phonenumber'];

            //return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          }

          //return Text("loading");
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white70,
                      child: ListTile(
                        leading: const Icon(
                          Icons.navigate_before,
                          size: 30.0,
                        ),
                        title: Text(
                          '    Report',
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60.0,
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
                      '${hospital}',
                      style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   'Dhaka',
                    //   style: TextStyle(
                    //       color: Colors.blueGrey[700],
                    //       fontWeight: FontWeight.bold),
                    // ),
                    Container(
                      padding: const EdgeInsets.all(25.0),
                      child: Center(child: Image.asset('images/cubes.png')),
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
                                    '${glucose} \n mmoI/L',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Glucose',
                                    style: TextStyle(
                                      fontSize: 20.0,
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
                                    '${cholesterol} mmoI/L',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Cholesterol',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.blueGrey[700]),
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
                                    '${bilirubin} mmoI/L',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Bilirubin',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.blueGrey[700]),
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
                                    '${rbc} \nmI/L',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '    RBC     ',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.blueGrey[700]),
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
                                    '${mvc} fl',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '       MVC     ',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.blueGrey[700]),
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
                                    '${platelets} bL',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '  Platelets  ',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.blueGrey[700]),
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
            bottomNavigationBar: Builder(builder: (context) {
              return FloatingActionButton.extended(
                onPressed: (() {}),
                backgroundColor: Colors.red,
                label: const Text('My Report'),
              );
            }),
          );
        });
  }
}
