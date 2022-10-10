import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/screens/home_screen.dart';
import 'package:ug_blood_donate/screens/map/order_traking_page.dart';
import 'package:ug_blood_donate/screens/profile.dart';
import 'package:ug_blood_donate/screens/upload.dart';
import 'package:ug_blood_donate/screens/find_donor.dart';
import 'package:ug_blood_donate/screens/donorcard.dart';
import 'package:ug_blood_donate/screens/report.dart';
import 'package:ug_blood_donate/screens/first_screens/twitter.dart';
import 'package:ug_blood_donate/posts/get_nofications.dart';
import 'package:ug_blood_donate/utils/firebase.dart';

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
  final screens = [
    const MyHomeScreen(),
    GeoApp(),
    UserNotification(),
    const Report_Page(),
    const WebViewExample(),
    DonorCard(),
    Upload(
      currentUser: firebaseAuth.currentUser!,
    ),
    ProfilePage(),
  ];

  @override
  void initState() {
    _bottomBarController.stream.listen((opened) {
      debugPrint('Bottom bar ${opened ? 'opened' : 'closed'}');
    });
    super.initState();
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
          height: 70,
          heightClosed: 70,
          heightOpened: 300,
          mainButtonPosition: MainButtonPosition.left,
          selectedItemIconColor: Colors.black,
          itemIconColor: Colors.white,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
            ),
          ),
        ),
        mainActionButtonTheme: MainActionButtonTheme(
          size: 55,
          color: Colors.green,
          splash: Colors.green[800],
          icon: IconButton(
            onPressed: () => _bottomBarController.toggleSheet(),
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
          BottomBarWithSheetItem(icon: Icons.maps_home_work),
          BottomBarWithSheetItem(icon: Icons.notifications_active_outlined),
          BottomBarWithSheetItem(icon: Icons.receipt_long_rounded),
          BottomBarWithSheetItem(icon: Icons.feed),
          BottomBarWithSheetItem(icon: Icons.card_membership),
          BottomBarWithSheetItem(icon: Icons.backup_rounded),
          BottomBarWithSheetItem(icon: Icons.person_outline_outlined),
        ],
      ),
    );
  }
}
