// import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:ug_blood_donate/screens/find_donor.dart';
// import 'package:ug_blood_donate/screens/request_blood.dart';
// import 'package:ug_blood_donate/screens/view_image.dart';
// import 'package:ug_blood_donate/utils/firebase.dart';

// import '../models/user_model.dart';

// //var currentUser = firebaseAuth.currentUser!;

// class MyHomeScreen extends StatefulWidget {
//   const MyHomeScreen({super.key});

//   @override
//   State<MyHomeScreen> createState() => _MyHomeScreenState();
// }

// class _MyHomeScreenState extends State<MyHomeScreen> {
//   var currentUser;

//   @override
//   void initState() {
//     super.initState();
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(currentUserId())
//         .get()
//         .then((value) {
//       //print('hi user');
//       setState(() {
//         currentUser = UserModel.fromMap(value.data());
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.lightBlueAccent,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               width: 260.0,
//             ),
//             const Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Icon(
//                   Icons.menu,
//                   size: 30.0,
//                 ),
//                 SizedBox(
//                   width: 160.0,
//                 ),
//                 Icon(
//                   Icons.qr_code,
//                   size: 30.0,
//                 ),
//                 Icon(
//                   Icons.notification_add,
//                   size: 30.0,
//                 ),
//               ],
//             ),
//             ListTile(
//               // leading: Image.network(''),
//               title: Text(
//                 'Welcome home',
//                 style: TextStyle(color: Colors.white54),
//               ),
//               subtitle: Text(
//                 'Donor Name',
//                 //'${currentUser.fullname}',
//                 style: TextStyle(color: Colors.white, fontSize: 20.0),
//               ),
//               // trailing: ClipRRect(
//               //   clipBehavior: Clip.hardEdge,
//               //   borderRadius: BorderRadius.circular(4.0),
//               //   child: Image.asset(
//               //     'assets/images/qr.pug',
//               //     width: 4,
//               //     height: 4,
//               //   ),
//               // ),
//             ),
//             const ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Color.fromARGB(255, 250, 248, 248),
//                 radius: 50,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.lightBlueAccent,
//                   radius: 36.0,
//                   child: Text(
//                     'AB+',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20.0,
//                         color: Colors.white),
//                   ),
//                 ),
//               ),
//               title: Text(
//                 '28 blood bag',
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 'The total blood you donate',
//                 style: TextStyle(color: Colors.white60),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               decoration: const BoxDecoration(
//                   color: Colors.white70,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(40.0),
//                       topRight: Radius.circular(40.0))),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20.0),
//                           topRight: Radius.circular(20.0),
//                           bottomLeft: Radius.circular(20.0),
//                           bottomRight: Radius.circular(20.0),
//                         )),
//                     child: const ListTile(
//                         title: Text(
//                           'Its time to donate!',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         subtitle:
//                             Text('Click to find the loction of the donor!'),
//                         trailing: CircleAvatar(
//                           backgroundColor: Colors.orange,
//                           child: Icon(
//                             Icons.arrow_forward_rounded,
//                             color: Colors.white,
//                           ),
//                         )),
//                   ),
//                   const SizedBox(
//                     height: 20.0,
//                   ),
//                   const Text(
//                     'Service',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                   ),
//                   const SizedBox(height: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       const SizedBox(
//                         width: 2.0,
//                       ),
//                       GestureDetector(
//                         onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => const Request(),
//                           ),
//                         ),
//                         child: Container(
//                           height: 250,
//                           width: 120.0,
//                           decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                   image: AssetImage("assets/images/rafiki.png"),
//                                   fit: BoxFit.cover),
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(40.0),
//                                 topRight: Radius.circular(40.0),
//                                 bottomLeft: Radius.circular(20.0),
//                                 bottomRight: Radius.circular(20.0),
//                               )),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Container(
//                                 padding:
//                                     const EdgeInsets.only(left: 10, bottom: 10),
//                                 child: const Card(
//                                   child: Icon(
//                                     Icons.search,
//                                     color: Colors.yellowAccent,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding:
//                                     const EdgeInsets.only(left: 10, bottom: 20),
//                                 child: const Text(
//                                   'Create\nRequest',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                       fontSize: 20.0),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 2.0,
//                       ),
//                       GestureDetector(
//                         onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => FindDonor(),
//                           ),
//                         ),
//                         child: Container(
//                           height: 250,
//                           width: 120.0,
//                           decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                   image: AssetImage("assets/images/rafiki.png"),
//                                   fit: BoxFit.cover),
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(40.0),
//                                 topRight: Radius.circular(40.0),
//                                 bottomLeft: Radius.circular(20.0),
//                                 bottomRight: Radius.circular(20.0),
//                               )),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Container(
//                                 padding:
//                                     const EdgeInsets.only(left: 10, bottom: 10),
//                                 child: const Card(
//                                   child: Icon(
//                                     Icons.search,
//                                     color: Colors.yellowAccent,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding:
//                                     const EdgeInsets.only(left: 10, bottom: 20),
//                                 child: const Text(
//                                   'Find\nPatient',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                       fontSize: 20.0),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/screens/find_donor.dart';
import 'package:ug_blood_donate/screens/request_blood.dart';
import 'package:ug_blood_donate/screens/view_image.dart';
import 'package:ug_blood_donate/utils/firebase.dart';

import '../models/user_model.dart';

//import 'package:particles_flutter/particles_flutter.dart';

class MyHomeScreen extends StatefulWidget {
  User? currentUser;
  MyHomeScreen({Key? key, required this.currentUser}) : super(key: key);
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        } else if (status == AnimationStatus.completed) {
          _animationController.repeat();
        }
      });

    _animationController.forward();
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId())
        .get()
        .then((value) {
      //print('hi user');
      setState(() {
        var currentUser = UserModel.fromMap(value.data());
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 2, 76),
        body: SingleChildScrollView(
          child: Column(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 260.0,
                ),
                const Divider(),
                CustomPaint(
                  // painter: MyCustomPainter(_animation.value),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.qr_code,
                        size: 30.0,
                      ),
                      SizedBox(
                        width: 190.0,
                      ),
                      Icon(
                        Icons.notification_add,
                        size: 30.0,
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                ),
                const ListTile(
                  // leading: Image.network(''),
                  title: Text(
                    'Welcome ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20.0),
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
                Container(
                  height: 650,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0))),
                  child: Stack(
                    children: [
                      CircularParticle(
                        width: w,
                        height: h,
                        awayRadius: w / 5,
                        numberOfParticles: 90,
                        speedOfParticles: 0.5,
                        maxParticleSize: 7,
                        particleColor:
                            Color.fromARGB(255, 225, 55, 55).withOpacity(.7),
                        awayAnimationDuration: Duration(milliseconds: 600),
                        awayAnimationCurve: Curves.easeInOutBack,
                        onTapAnimation: true,
                        isRandSize: true,
                        isRandomColor: false,
                        connectDots: true,
                        // randColorList: [
                        // Colors.red.withAlpha(210),
                        // Colors.white.withAlpha(210),
                        // Colors.yellow.withAlpha(210),
                        // Colors.green.withAlpha(210),
                        // ],
                        enableHover: true,
                        hoverColor: Colors.black,
                        hoverRadius: 90,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 250, 242, 242),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                )),
                            child: const ListTile(
                                title: Text(
                                  'Its time to donate Blood!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                    'Click to find the available Donation Centres!'),
                                trailing: CircleAvatar(
                                  backgroundColor: Colors.pink,
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
                            'Services',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          //GestureDetector(
                          // onTap: () {},
                          // // => Navigator.push(
                          // //       context,
                          // //       MaterialPageRoute(
                          // //         builder: (_) => FindDonor(),
                          // //       ),
                          // // ),
                          // child: Container(
                          //   height: 50,
                          //   width: 120.0,
                          //   decoration: const BoxDecoration(
                          //       image: DecorationImage(
                          //           image: AssetImage(
                          //               "assets/images/rafiki.png"),
                          //           fit: BoxFit.cover),
                          //       borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(40.0),
                          //         topRight: Radius.circular(40.0),
                          //         bottomLeft: Radius.circular(20.0),
                          //         bottomRight: Radius.circular(20.0),
                          //       )),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [
                          //       Container(
                          //         padding: const EdgeInsets.only(
                          //             left: 10, bottom: 10),
                          //         child: const Card(
                          //           child: Icon(
                          //             Icons.search,
                          //             color: Colors.yellowAccent,
                          //           ),
                          //         ),
                          //       ),
                          //       Container(
                          //         padding: const EdgeInsets.only(
                          //             left: 10, bottom: 20),
                          //         child: const Text(
                          //           'Find\nPatient',
                          //           style: TextStyle(
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.black,
                          //               fontSize: 20.0),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ]),
        ));
  }
}

class mycard extends StatelessWidget {
  final Widget cardChild;
  final Widget page;

  mycard({super.key, required this.cardChild, required this.page});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(15),
        height: 180,
        width: 90,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 243, 248, 247),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: cardChild,
      ),
    );
  }
}

class icondata extends StatelessWidget {
  final String label;
  final IconData icon;

  const icondata({super.key, required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 40,
          color: const Color.fromARGB(234, 239, 52, 83),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final double animationValue;

  MyCustomPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (int value = 3; value >= 0; value--) {
      circle(canvas, Rect.fromLTRB(0, 0, size.width, size.height),
          value + animationValue);
    }
  }

  void circle(Canvas canvas, Rect rect, double value) {
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 247, 247, 247)
          .withOpacity((1 - (value / 4)).clamp(.0, 1));

    canvas.drawCircle(rect.center,
        sqrt((rect.width * .5 * rect.width * .5) * value / 4), paint);
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}
