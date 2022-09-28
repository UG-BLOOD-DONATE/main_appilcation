// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ug_blood_donate/home.dart';

const String myhomepageRoute = '/';
const String myprofileRoute = 'profile';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case myhomepageRoute:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      case myprofileRoute:
        return MaterialPageRoute(builder: (_) => MyProfilePage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('404 Not found')),
                ));
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    CollectionReference create_event =
        FirebaseFirestore.instance.collection('create_event');
    return const MaterialApp(
        title: "Create event",
        home: MyHomePage(),
        onGenerateRoute: Router.generateRoute,
        initialRoute: myhomepageRoute);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _auth = FirebaseAuth.instance;
  late User currentUser;
  TextEditingController location = TextEditingController();
  TextEditingController hospital = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController note = TextEditingController();
  //var measure;

  void _submit() {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user can tap anywhere to close the pop up
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('Your event has been created'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset('assets/successful.png'),
                const SizedBox(
                  height: 10,
                ),
                const Text('Your request has been sent'),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Image.asset('assets/back_arr.png'),
                ),
                // const Align(
                //     alignment: Alignment.topLeft,
                //     child: Text("Full name:",
                //         style: TextStyle(fontWeight: FontWeight.w700))),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Text(firstName + " " + lastName),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // const Align(
                //     alignment: Alignment.topLeft,
                //     child: Text("Body Temperature:",
                //         style: TextStyle(fontWeight: FontWeight.w700))),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Text("$bodyTemp ${measure == 1 ? "ºC" : "ºF"}"),
                // )
              ],
            ),
          ),
          // actions: <Widget>[
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: <Widget>[
          //       TextButton(
          //         style: TextButton.styleFrom(
          //           primary: Colors.white,
          //           backgroundColor: Colors.grey,
          //           shape: const RoundedRectangleBorder(
          //               borderRadius: BorderRadius.all(Radius.circular(10))),
          //         ),
          //   child: const Text('Go to profile'),
          //   onPressed: () async {
          //     FocusScope.of(context)
          //         .unfocus(); // unfocus last selected input field
          //     Navigator.pop(context);
          //     await Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) =>
          //                     MyProfilePage())) // Open my profile
          //         .then((_) => _formKey.currentState ?.reset()); // Empty the form fields
          //     setState(() {});
          //   }, // so the alert dialog is closed when navigating back to main page
          // ),
          // TextButton(
          //   style: TextButton.styleFrom(
          //     primary: Colors.white,
          //     backgroundColor: Colors.blue,
          //     shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(10))),
          //   ),
          //   child: const Text('OK'),
          //   onPressed: () {
          //     Navigator.of(context).pop(); // Close the dialog
          //     FocusScope.of(context)
          //         .unfocus(); // Unfocus the last selected input field
          //     _formKey.currentState?.reset(); // Empty the form fields
          //   },
          // )
          //     ],
          //   )
          // ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference create_event =
        FirebaseFirestore.instance.collection('create_event');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 32.0, color: Colors.pink),
          onPressed: () => Navigator.pop(context, true // MaterialPageRoute(
              //   builder: (_) => Home(
              //     currentUser: null,
              //   ),
              // ),
              ),
        ),
        backgroundColor: const Color.fromARGB(255, 254, 255, 255),
        title: const Text(
          "Create Event",
          style: TextStyle(
            color: Color.fromARGB(0, 11, 11, 11),
          ),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.account_circle, size: 32.0),
        //     tooltip: 'Profile',
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => MyProfilePage(),
        //           ));
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // const Align(
              //   alignment: Alignment.topLeft,
              //   child: Text("Enter your data",
              //       style: TextStyle(
              //         fontSize: 24,
              //       )),
              // ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextFormField(
                      controller: location,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.location_on_rounded,
                            color: Color.fromARGB(234, 239, 52, 83),
                          ),
                          labelText: 'Location',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          return 'location must contain at least 3 characters';
                        } else if (value
                            .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                          return 'location cannot contain special characters';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: hospital,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.home,
                            color: Color.fromARGB(234, 239, 52, 83),
                          ),
                          labelText: 'Hospital',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          return 'Last Name must contain at least 3 characters';
                        } else if (value
                            .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                          return 'Last Name cannot contain special characters';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: date,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.calendar_month,
                            color: Color.fromARGB(234, 239, 52, 83),
                          ),
                          labelText: 'Date',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                          return 'Use only numbers!';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: contact,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.phone,
                            color: Color.fromARGB(234, 239, 52, 83),
                          ),
                          labelText: 'Contact',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 10) {
                          return 'mobile numcer must contain at least 10 characters';
                        } else if (value.contains(RegExp(r'^[_\-=,\.;]$'))) {
                          return 'Description cannot contain special characters';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                   //
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // DropdownButtonFormField(
                    //     decoration: const InputDecoration(
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(20.0)),
                    //           borderSide:
                    //               BorderSide(color: Colors.grey, width: 0.0),
                    //         ),
                    //         border: OutlineInputBorder()),
                    //     items: const [
                    //       DropdownMenuItem(
                    //         child: Text("ºC"),
                    //         value: 1,
                    //       ),
                    //       DropdownMenuItem(
                    //         child: Text("ºF"),
                    //         value: 2,
                    //       )
                    //     ],
                    //     hint: const Text("Select item"),
                    //     onChanged: (value) {
                    //       setState(() {
                    //         measure = value;
                    //         // measureList.add(measure);
                    //       });
                    //     },
                    //     onSaved: (value) {
                    //       setState(() {
                    //         measure = value;
                    //       });
                    //     }),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      //color: Color.fromARGB(234, 239, 52, 83),
                      onPressed: () {
                        const CircularProgressIndicator(
                          color: Colors.white,
                        );

                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          create_event.add({
                            'location': location.text,
                            'hospital': hospital.text,
                            'date': date.text,
                            'contact': contact.text,
                           // 'note': note.text
                          }).then((value) => Fluttertoast.showToast(
                                      msg: "Event created successfully")
                                  .catchError((e) {
                                print("Event not creaetd");
                              }));
                          Navigator.pop(context, true
                              // MaterialPageRoute(
                              //   builder: (context) => Home(),
                              // ),
                              );
                        }
                      },
                      child: const Center(child: Text("ADD EVENT")),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            const Text("New data",
                style: TextStyle(
                  fontSize: 24,
                )),
            const Spacer(),
            ElevatedButton(
              child: const Text('New'),
              onPressed: () => Navigator.pop(context),
            )
          ]),
        ]),
      ),
    );
  }
}

extension StringExtension on String {
  // Method used for capitalizing the input from the form
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
