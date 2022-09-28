import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ug_blood_donate/home.dart';
import 'package:ug_blood_donate/models/user_model.dart';
import 'package:ug_blood_donate/screens/first_screens/loginScreen.dart';

Future<Placemark> getloca() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  return placemarks[0];
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? _image;
  final picker = ImagePicker();
  bool showProgress = false;
  bool _isObscure = true;
  bool _isObscure2 = true;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController telno = TextEditingController();
  TextEditingController bloodtype = TextEditingController();
  TextEditingController location = TextEditingController();

  Future<dynamic> getUserLocation() async {
    Placemark placemark = await getloca();
    String completeAddress =
        '${placemark..subThoroughfare} ${placemark.administrativeArea} ${placemark.country} ${placemark.postalCode} ${placemark.subLocality}';
    String formattedAddress = "${placemark.locality}, ${placemark.country}";
    print(completeAddress);
    location.text = formattedAddress;
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

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return MaterialApp(
        title: 'ug_donate_blood',
        home: Scaffold(
            appBar: null,
            // body is the majority of the screen.
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 34,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                width: 300,
                                height: 300,
                              ),
                            ],
                          ),
                          // const SizedBox(height: 30),
                          // Container(
                          //   child: _image == null
                          ///      ? Center(
                          //           child: GestureDetector(
                          //             onTap: () => getImage(),
                          //             child: const CircleAvatar(
                          //               backgroundColor:
                          //                   Color.fromARGB(255, 236, 34, 98),
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
                          //         var my_imageUrl = uploadImage(_image);
                          //       }
                          //     },
                          //   ),
                          // ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.pink,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                hintText: 'FullName'),
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.pink,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                hintText: 'Email'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                suffixIcon: IconButton(
                                    color: Colors.pink,
                                    icon: Icon(_isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    }),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.pink,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                hintText: 'Password'),
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("please enter valid password min. 6 character");
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: confirmpassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                suffixIcon: IconButton(
                                    color: Colors.pink,
                                    icon: Icon(_isObscure2
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure2 = !_isObscure2;
                                      });
                                    }),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.pink,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                hintText: 'Confirm password'),
                            validator: (value) {
                              if (password.text != confirmpassword.text) {
                                return "Password did not match";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: telno,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.pink,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                hintText: 'Phone number'),
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: bloodtype,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                filled: true,
                                fillColor: Colors.grey[200],
                                prefixIcon: const Icon(
                                  Icons.bloodtype,
                                  color: Colors.pink,
                                ),
                                hintText: 'BloodType'),
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: location,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                prefixIcon: const Icon(
                                  Icons.location_on,
                                  color: Colors.pink,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.pink),
                                    borderRadius: BorderRadius.circular(9.0)),
                                hintText: 'Village, City.'),
                            keyboardType: TextInputType.streetAddress,
                          ),
                          const Divider(),
                          Container(
                            width: 200.0,
                            height: 100.0,
                            alignment: Alignment.center,
                            child: ElevatedButton.icon(
                              onPressed: () => getUserLocation(),
                              icon: const Icon(Icons.my_location),
                              label: const Text(
                                'get current loc',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 300,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          showProgress = true;
                                        });
                                        Future.delayed(
                                            const Duration(seconds: 3), (() {
                                          setState(() {
                                            showProgress = false;
                                          });
                                        }));

                                        signUp(
                                          email.text,
                                          password.text,
                                        );
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.pink),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                      ),
                                      child: showProgress
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : const Text(
                                              'REGISTER',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            )))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return const LoginScreen();
                                    }),
                                  );
                                },
                                child: const Text(
                                  'Log In.',
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      UserCredential userCredential = (await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      })) as UserCredential;
    }
  }

  // uploadImage(img) async {
  // Initialize Firebase once again
  // await Firebase.initializeApp();
  // var random = Random();
  // var rand = random.nextInt(1000000000);
  // // Give the image a random name
  // String name = "image:$rand";
  // try {
  //   await FirebaseStorage.instance
  //       // Give the image a name
  //       .ref('$name.jpg')
  //       // Upload image to firebase
  //       .putFile(img);
  //   print("Uploaded image");
  // } on FirebaseException catch (e) {
  //   print(e);
  // }
  // Future<String> uploadImage(imageFile) async {
  //   UploadTask uploadTask = storageRef.child("$name.jpg").putFile(imageFile);
  //   var imageUrl = await (await uploadTask).ref.getDownloadURL();
  //   return imageUrl.toString();
  // }

  postDetailsToFirestore() async {
    // if (_image != null) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullname = name.text;
    userModel.phonenumber = telno.text;
    userModel.bloodType = bloodtype.text;
    userModel.location = location.text;
    userModel.photoURL = null;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
    // } else {
    //   Fluttertoast.showToast(msg: "Add profile pic:");
    // }
  }
}
