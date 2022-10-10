import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/screens/find_donor.dart';
import 'package:ug_blood_donate/screens/request_blood.dart';
import 'package:ug_blood_donate/screens/view_image.dart';
import 'package:ug_blood_donate/utils/firebase.dart';

import '../models/user_model.dart';

//var currentUser = firebaseAuth.currentUser!;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  var currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId())
        .get()
        .then((value) {
      //print('hi user');
      setState(() {
        currentUser = UserModel.fromMap(value.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 260.0,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.menu,
                  size: 30.0,
                ),
                SizedBox(
                  width: 160.0,
                ),
                Icon(
                  Icons.qr_code,
                  size: 30.0,
                ),
                Icon(
                  Icons.notification_add,
                  size: 30.0,
                ),
              ],
            ),
            ListTile(
              // leading: Image.network(''),
              title: Text(
                'Welcome home',
                style: TextStyle(color: Colors.white54),
              ),
              subtitle: Text(
                'Donor Name',
                //'${currentUser.fullname}',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              // trailing: ClipRRect(
              //   clipBehavior: Clip.hardEdge,
              //   borderRadius: BorderRadius.circular(4.0),
              //   child: Image.asset(
              //     'assets/images/qr.pug',
              //     width: 4,
              //     height: 4,
              //   ),
              // ),
            ),
            const ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 250, 248, 248),
                radius: 50,
                child: CircleAvatar(
                  backgroundColor: Colors.lightBlueAccent,
                  radius: 36.0,
                  child: Text(
                    'AB+',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                ),
              ),
              title: Text(
                '28 blood bag',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'The total blood you donate',
                style: TextStyle(color: Colors.white60),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        )),
                    child: const ListTile(
                        title: Text(
                          'Its time to donate!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle:
                            Text('Click to find the loction of the donor!'),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Service',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 2.0,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Request(),
                          ),
                        ),
                        child: Container(
                          height: 250,
                          width: 120.0,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/rafiki.png"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child: const Card(
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.yellowAccent,
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 20),
                                child: const Text(
                                  'Create\nRequest',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FindDonor(),
                          ),
                        ),
                        child: Container(
                          height: 250,
                          width: 120.0,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/rafiki.png"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child: const Card(
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.yellowAccent,
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 20),
                                child: const Text(
                                  'Find\nPatient',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
