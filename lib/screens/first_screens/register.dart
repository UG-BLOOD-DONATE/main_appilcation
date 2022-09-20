import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ug_blood_donate/models/user_model.dart';
import 'package:ug_blood_donate/screens/first_screens/loginScreen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
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
                      SizedBox(height: 30),
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.pink,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            hintText: 'FullName'),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.pink,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            hintText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 10),
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
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.pink,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.pink),
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
                      SizedBox(height: 10),
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
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.pink,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            hintText: 'Confirm password'),
                            validator: (value) {
                            if (password.text !=
                               confirmpassword.text) {
                              return "Password did not match";
                            } else {
                              return null;
                            }
                          },
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: telno,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.pink,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            hintText: 'Phone number'),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: bloodtype,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.bloodtype,
                              color: Colors.pink,
                            ),
                            hintText: 'BloodType'),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: location,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.pink,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.pink),
                                borderRadius: BorderRadius.circular(9.0)),
                            hintText: 'Village, City.'),
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 300,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    signUp(
                                      email.text,
                                      password.text,
                                    );
                                  },
                                  child: Text(
                                    'REGISTER',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.pink),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  )))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
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
                                  return LoginScreen();
                                }),
                              );
                            },
                            child: Text(
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
              ),
            )));
  }

  signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      
        UserCredential userCredential =
            (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ).then((value) => {
          postDetailsToFirestore()
        }).catchError((e)
        {
           Fluttertoast.showToast(msg: e!.message);
        })) as UserCredential;
       
      
    }
  }
  
  postDetailsToFirestore() async
   {
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
User? user = _auth.currentUser;

UserModel userModel = UserModel();


userModel.email = user!.email;
userModel.uid = user.uid;
userModel.fullname = name.text;
userModel.phonenumber = telno.text;
userModel.bloodType = bloodtype.text;
userModel.location = location.text;


await firebaseFirestore
   .collection("users")
   .doc(user.uid)
   .set(userModel.toMap());
Fluttertoast.showToast(msg: "Account created successfully");

Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );






   }
}
