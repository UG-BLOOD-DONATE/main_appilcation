import 'package:flutter/material.dart';
import 'package:ug_blood_donate/home.dart';
import 'package:ug_blood_donate/screens/first_screens/loginScreen.dart';
import 'register.dart';

class Frist_Home extends StatelessWidget {
  const Frist_Home({super.key});

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 34,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ugblood donate.png',
                          width: 300,
                          height: 350,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'You can donate for ones in need and  ',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[90]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'request blood if you need. ',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[900]),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
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
                              'LOG IN',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused))
                                  return Colors.pink[300];
                                if (states.contains(MaterialState.hovered))
                                  return Colors.pink[300];
                                if (states.contains(MaterialState.pressed))
                                  return Colors.pink[300];
                                return null; // Defer to the widget's default.
                              }),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.pink),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return const RegisterPage();
                                }),
                              );
                            },
                            child: const Text(
                              'REGISTER',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused))
                                  return Colors.pink[300];
                                if (states.contains(MaterialState.hovered))
                                  return Colors.pink[300];
                                if (states.contains(MaterialState.pressed))
                                  return Colors.pink[300];
                                return null; // Defer to the widget's default.
                              }),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.pink),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
