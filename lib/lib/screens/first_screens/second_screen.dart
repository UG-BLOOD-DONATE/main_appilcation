import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/components/buttom_navigation_left_button.dart';
import 'package:ug_blood_donate/home.dart';
//import 'package:ug_blood_donate/screens/bottom_navigation.dart';
import 'package:ug_blood_donate/screens/first_screens/LoginRegister.dart';
import 'package:ug_blood_donate/screens/first_screens/third_sreen.dart';
import 'package:ug_blood_donate/screens/home_screen.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late StreamSubscription<User?> user;
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LeftButton(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 90.0),
                  child: Center(child: Image.asset('assets/images/Vector.png')),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    'Find Blood Donors',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Locate a blood donor nearby',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                    Text(
                      'and contact them to help you',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                    Text(
                      'incase of an emergency',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Frist_Home(),
                              ),
                            ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          "Skip",
                          style: TextStyle(color: Colors.black),
                        )),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Onboarding2(),
                        ),
                      ),
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.green),
                      child: Text("Next"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ug_blood_donate/screens/home_screen.dart';
// import 'package:ug_blood_donate/screens/map/order_traking_page.dart';
// import 'package:ug_blood_donate/screens/profile.dart';
// import 'package:ug_blood_donate/screens/upload.dart';
// import 'package:ug_blood_donate/screens/donorcard.dart';
// import 'package:ug_blood_donate/screens/report.dart';
// import 'package:ug_blood_donate/screens/first_screens/twitter.dart';
// import 'package:ug_blood_donate/posts/get_nofications.dart';
// import 'package:ug_blood_donate/utils/firebase.dart';

// //void main() => runApp(const LeftButtonExample());

// class LeftButton extends StatelessWidget {
//   const LeftButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final _bottomBarController = BottomBarWithSheetController(initialIndex: 0);
//   int index = 0;
//   User? currentUser = FirebaseAuth.instance.currentUser;

//   final screens = [
//     MyHomeScreen(
//       currentUser: FirebaseAuth.instance.currentUser,
//     ),
//     UserNotification(),
//     //GeoApp(),
//     UserNotification(),
//     const Report_Page(),
//     const WebViewExample(),
//     DonorCard(),
//     Upload(
//       currentUser: firebaseAuth.currentUser!,
//     ),
//     ProfilePage(),
//   ];

//   @override
//   void initState() {
//     _bottomBarController.stream.listen((opened) {
//       debugPrint('Bottom bar ${opened ? 'opened' : 'closed'}');
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF111111),
//       body: screens[index],
//       bottomNavigationBar: BottomBarWithSheet(
//         // controller: _bottomBarController,
//         //  autoClose: false,
//         sheetChild: Center(
//           child: Text(
//             "Another content",
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 20,
//               fontWeight: FontWeight.w900,
//             ),
//           ),
//         ),
//         bottomBarTheme: const BottomBarTheme(
//           height: 10,
//           isVerticalItemLabel: false,
//           heightClosed: 70,
//           heightOpened: 0,
//           mainButtonPosition: MainButtonPosition.middle,
//           selectedItemIconColor: Colors.black,
//           itemIconColor: Colors.white,
//           decoration: BoxDecoration(
//             color: Color.fromARGB(255, 248, 2, 76),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(30.0),
//               bottomRight: Radius.circular(30.0),
//             ),
//           ),
//         ),
//         mainActionButtonTheme: MainActionButtonTheme(
//           size: 55,
//           color: Colors.green,
//           splash: Colors.green[800],
//           icon: IconButton(
//             onPressed: () => _bottomBarController.toggleSheet(),
//             icon: Icon(Icons.add),
//             color: Colors.white,
//             iconSize: 35,
//           ),
//         ),
//         onSelectItem: (index) {
//           setState(() {
//             this.index = index;
//           });
//         },
//         items: const [
//           BottomBarWithSheetItem(icon: Icons.home_rounded),
//           BottomBarWithSheetItem(icon: Icons.maps_home_work),
//           BottomBarWithSheetItem(icon: Icons.notifications_active_outlined),
//           BottomBarWithSheetItem(icon: Icons.receipt_long_rounded),
//           BottomBarWithSheetItem(icon: Icons.feed),
//           BottomBarWithSheetItem(icon: Icons.card_membership),
//           BottomBarWithSheetItem(icon: Icons.backup_rounded),
//           BottomBarWithSheetItem(icon: Icons.person_outline_outlined),
//         ],
//       ),
//     );
//   }
// }
