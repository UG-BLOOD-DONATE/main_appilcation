import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ug_blood_donate/components/custom_card.dart';
import 'package:ug_blood_donate/home.dart';
import 'package:ug_blood_donate/models/user_model.dart';
import 'package:ug_blood_donate/screens/first_screens/LoginRegister.dart';
import 'package:ug_blood_donate/utils/firebase.dart';
import 'package:path/path.dart' as path;

//File? _image;
final picker = ImagePicker();

class ProfilePage extends StatefulWidget {
  String? userId;
  ProfilePage({Key? key, this.userId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }

  final _db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  String profilePicLink = "";

  void pickUploadProfilePic({String? userId}) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${widget.userId}/images")
        .child("post_$postID");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      loggedInUser.photoURL = value.toString();
      await _db.collection("users").doc("${widget.userId}").set(
            loggedInUser.toMap(),
            SetOptions(
              merge: true,
            ),
          );
      setState(() {
        profilePicLink = value;
        loggedInUser.photoURL = value.toString();
      });
    });
    print(profilePicLink);
  }

  // getImage() async {
  //   // You can also change the source to gallery like this: "source: ImageSource.camera"
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image has been selected.');
  //     }
  //   });
  // }

  // Future<String> uploadImage(imageFile) async {
  //   var random = Random();
  //   var rand = random.nextInt(1000000000);
  //   // Give the image a random name
  //   String name = "image:$rand";
  //   UploadTask uploadTask = storageRef.child("$name.jpg").putFile(imageFile);
  //   var imageUrl = await (await uploadTask).ref.getDownloadURL();
  //   return imageUrl.toString();
  // }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      //print('hi user');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.navigate_before_sharp,
            color: Colors.black,
            size: 24.0,
          ),
          title: const Text("Profile"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.edit_note_sharp,
                color: Colors.black,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),

        // body is the majority of the screen.
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   child: _image == null
              //       ? Center(
              //           child: GestureDetector(
              //             onTap: () => getImage(),
              //             child: const CircleAvatar(
              //               backgroundColor: Color.fromARGB(255, 236, 34, 98),
              //               radius: 60,
              //               child: Icon(Icons.add_a_photo_outlined),
              //             ),
              //           ),
              //         )
              //       : Center(child: Image.file(_image!)),
              // ),
              // Center(
              //   child: FloatingActionButton(
              //     backgroundColor: Color.fromARGB(255, 236, 34, 98),
              //     child: Icon(Icons.upload),
              //     onPressed: () {
              //       if (_image != null) {
              //         setState(() {
              //           loggedInUser.photoURL = uploadImage(_image) as String?;
              //         });
              //       }
              //     },
              //   ),
              // ),
              const SizedBox(
                height: 34,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: GestureDetector(
                      onDoubleTap: () {
                        pickUploadProfilePic(userId: loggedInUser.uid);
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(120, 5, 40, 24),
                        height: 120,
                        width: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: primary,
                        ),
                        child: Center(
                          child: loggedInUser.photoURL == null
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 80,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(loggedInUser.photoURL!),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    /*1*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*2*/
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                          child: Text(
                            "${loggedInUser.fullname}",
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
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.pink[500]),
                  Text(
                    "${loggedInUser.location}",
                  )
                ],
              ),
              const SizedBox(
                height: 20,
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
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(150, 27, 158, 163)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
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
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                      width: 105,
                      height: 100,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              "${loggedInUser.bloodType}",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Blood Type',
                              style:
                                  TextStyle(fontSize: 8, color: Colors.black),
                            ),
                          ))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    /*1*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 100,
                            height: 105,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                                child: const ListTile(
                                  title: Text(
                                    '05',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Donated',
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.black),
                                  ),
                                ))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    /*1*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 100,
                            height: 110,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                                child: const ListTile(
                                  title: Text(
                                    '02',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Requested',
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.black),
                                  ),
                                )))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: Container(
                  height: 60,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.pink,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        /*1*/
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              'Available for donate',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      /*3*/
                      Icon(
                        Icons.toggle_on,
                        color: Colors.pink[500],
                        size: 50,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                child: Container(
                  height: 60,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.messenger, color: Colors.pink[500]),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Invite a friend",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                child: Container(
                  height: 60,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.info, color: Colors.pink[500]),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Get help",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                child: Container(
                  height: 60,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.logout_rounded, color: Colors.pink[500]),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomCard(
                        onTap: () {
                          firebaseAuth.signOut();
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (_) => const Frist_Home()));
                        },
                        child: const Text(
                          "Sign Out",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

  Future<void> _upload(String inputSource) async {}
}
