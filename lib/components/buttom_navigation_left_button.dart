import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/screens/first_screens/second_screen.dart';
import 'package:ug_blood_donate/screens/home_screen.dart';
import 'package:ug_blood_donate/screens/map/order_traking_page.dart';
import 'package:ug_blood_donate/screens/profile.dart';
import 'package:ug_blood_donate/screens/upload.dart';
import 'package:ug_blood_donate/screens/donorcard.dart';
import 'package:ug_blood_donate/screens/report.dart';
import 'package:ug_blood_donate/screens/first_screens/twitter.dart';
import 'package:ug_blood_donate/posts/get_nofications.dart';
import 'package:ug_blood_donate/utils/firebase.dart';

import '../Chatsection/main.dart';
import '../Chatsection/pages/home_page.dart';
import '../screens/first_screens/getposts.dart';

//void main() => runApp(const LeftButtonExample());

class LeftButton extends StatelessWidget {
  const LeftButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bottomBarController = BottomBarWithSheetController(initialIndex: 0);
  int index = 0;
  User? currentUser = FirebaseAuth.instance.currentUser;

  final screens = [
    MyHomeScreen(
      currentUser: FirebaseAuth.instance.currentUser,
    ),
    //UserNotification(),
    //GeoApp(),
    //UserNotification(),
    const Report_Page(),
    const WebViewExample(),
    // DonorCard(),
    displayposts(),
    HomePage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    _bottomBarController.stream.listen((opened) {
      debugPrint('Bottom bar ${opened ? 'opened' : 'closed'}');
    });
    super.initState();
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

            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => LeftButton(),
            //   ),
            // );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: screens[index],
      bottomNavigationBar: BottomBarWithSheet(
        controller: _bottomBarController,
        autoClose: false,
        sheetChild: Center(
          child: Text(
            "Another content",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        bottomBarTheme: const BottomBarTheme(
          isVerticalItemLabel: false,
          height: 50,
          // heightClosed: 0,
          // heightOpened: 0,
          mainButtonPosition: MainButtonPosition.middle,
          selectedItemIconColor: Colors.black,
          itemIconColor: Colors.white,
          itemIconSize: 28,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 248, 2, 76),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),
        mainActionButtonTheme: MainActionButtonTheme(
          size: 55,
          //color: Colors.green,
          //splash: Colors.green[800],
          icon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            color: Colors.white,
            iconSize: 35,
          ),
        ),
        onSelectItem: (index) {
          setState(() {
            this.index = index;
          });
        },
        items: const [
          BottomBarWithSheetItem(icon: Icons.home_rounded),
          //BottomBarWithSheetItem(icon: Icons.maps_home_work),
          //, BottomBarWithSheetItem(icon: Icons.notifications_active_outlined),
          BottomBarWithSheetItem(icon: Icons.receipt_long_rounded),
          BottomBarWithSheetItem(icon: Icons.feed),
          BottomBarWithSheetItem(icon: Icons.card_membership),
          BottomBarWithSheetItem(icon: Icons.chat),
          BottomBarWithSheetItem(icon: Icons.person_outline_outlined),
        ],
      ),
    );
  }
}
