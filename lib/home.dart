// ignore_for_file: non_constant_identifier_names, avoid_unnecessary_containers

//import 'package:provider/provider.dart';

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:ug_blood_donate/Chatsection/pages/home_page.dart';
import 'package:ug_blood_donate/Doctor_side/screen/create_event.dart';
import 'package:ug_blood_donate/models/tab_icon_data.dart';
import 'package:ug_blood_donate/posts/create_post.dart';
import 'package:ug_blood_donate/posts/get_nofications.dart';
import 'package:ug_blood_donate/posts/timeline.dart';
import 'package:ug_blood_donate/screens/bottom_navigation.dart';
import 'package:ug_blood_donate/screens/chat/chartpage.dart';
import 'package:ug_blood_donate/screens/doner_profile.dart';
import 'package:ug_blood_donate/screens/donorcard.dart';
import 'package:ug_blood_donate/screens/find_donor.dart';
import 'package:ug_blood_donate/screens/first_screens/twitter.dart';
import 'package:ug_blood_donate/screens/map/order_traking_page.dart';
import 'package:ug_blood_donate/screens/map/test_map.dart';
import 'package:ug_blood_donate/screens/profile.dart';
import 'package:ug_blood_donate/screens/report.dart';
import 'package:ug_blood_donate/screens/request_blood.dart';
import 'package:ug_blood_donate/screens/social_media_news_feeds.dart';
import 'package:ug_blood_donate/screens/upload.dart';
import 'package:ug_blood_donate/models/user_model.dart';
import 'package:ug_blood_donate/Chataaaapppp/screens/home_screen.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final storageRef = FirebaseStorage.instance.ref();
final postRef = FirebaseFirestore.instance.collection('posts');
final userRef = FirebaseFirestore.instance.collection('users');
final timelineRef = FirebaseFirestore.instance.collection('timeline');
//User currentUser;

class Home extends StatefulWidget {
  User currentUser;
  //const Upload({super.key, required this.currentUser});
  Home({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  //final User user = ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          //IconButton
          IconButton(
            icon: const Icon(Icons.notifications),
            color: const Color.fromRGBO(239, 52, 83, 0.918),
            tooltip: 'Setting Icon',
            onPressed: () {},
          ), //IconButton
        ], //<Widget>[]
        backgroundColor: const Color(0x00000000),
        elevation: 50.0,
        leading: IconButton(
          icon: const Icon(Icons.menu_sharp),
          color: const Color.fromARGB(234, 239, 52, 83),
          tooltip: 'Menu Icon',
          onPressed: () {},
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ), //AppBar
      body: SingleChildScrollView(
        child: Container(
          child: BuildBody(currentUser: widget.currentUser),
        ),
      ),
      bottomNavigationBar: SizedBox(
          height: 62, child: BottomBarView(tabIconsList: tabIconsList)),
    );
  }
}

class BuildBody extends StatefulWidget {
  final User currentUser;
  const BuildBody({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  bool isToggle = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      color: const Color.fromARGB(255, 254, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),

          const SizedBox(
            height: 10,
          ),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: imageSliders,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  mycard(
                    cardChild: icondata(
                      label: 'Find Donors',
                      icon: Icons.search,
                    ),
                    page: FindDonor(),
                  ),
                  mycard(
                    cardChild:
                        icondata(label: ' Request', icon: Icons.bloodtype),
                    page: Request(),
                  ),
                  mycard(
                    cardChild: icondata(
                        label: 'Campaign', icon: Icons.campaign_outlined),
                    page: UserNotification(),
                    //  page: DonerProfilePage(),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  mycard(
                    cardChild: const icondata(
                        label: 'Assistant', icon: Icons.assistant_navigation),
                    page: ChatPage(
                      title: 'Assistant',
                    ),
                  ),
                  mycard(
                    cardChild: icondata(label: 'Map', icon: Icons.map_outlined),
                    page: GeoApp(),
                    //OrderTrackingPage(),
                  ),
                  mycard(
                    cardChild:
                        const icondata(label: 'Report', icon: Icons.report),
                    page: ProfilePage(userId: widget.currentUser.uid),
                  ),
                ],
              )
            ],
          ),
          //   ],
          // ),
          const Center(
              child: Text(
            'Twitter feeds.',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
          Center(
            child: ElevatedButton(
              //   child: WebViewExample(),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const WebViewExample())),
              child: Container(
                color: Color.fromARGB(0, 251, 251, 251),
                padding: const EdgeInsets.all(10),
                width: 150,
                height: 100,
                child: const Text(
                    'see all twitter feeds about blood donation in Uganda >>>'),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              //   child: WebViewExample(),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (_) => Create_post(),
                  builder: (_) => Upload(
                    currentUser: widget.currentUser,
                  ),
                ),
              ),
              child: Container(
                color: Color.fromARGB(0, 251, 251, 251),
                padding: const EdgeInsets.all(10),
                width: 150,
                height: 100,
                child: const Text('upload post >>>'),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              //   child: WebViewExample(),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (_) => Create_post(),
                  builder: (_) => Timeline(
                    currentUser: widget.currentUser,
                  ),
                ),
              ),
              child: Container(
                color: Color.fromARGB(0, 251, 251, 251),
                padding: const EdgeInsets.all(10),
                width: 150,
                height: 100,
                child: const Text('view timeline >>>'),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              //   child: WebViewExample(),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DonerProfilePage(),
                ),
              ),
              child: Container(
                color: Color.fromARGB(0, 251, 251, 251),
                padding: const EdgeInsets.all(10),
                width: 150,
                height: 100,
                child: const Text('doner profile >>>'),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              //   child: WebViewExample(),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MyHomePage(),
                ),
              ),
              child: Container(
                color: Color.fromARGB(0, 251, 251, 251),
                padding: const EdgeInsets.all(10),
                width: 150,
                height: 100,
                child: const Text('doner profile >>>'),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              //   child: WebViewExample(),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Report_Page(),
                ),
              ),
              child: Container(
                color: Color.fromARGB(0, 251, 251, 251),
                padding: const EdgeInsets.all(10),
                width: 150,
                height: 100,
                child: const Text('see feeds >>>'),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              //   child: WebViewExample(),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HomePage(),
                ),
              ),
              child: Container(
                color: Color.fromARGB(0, 251, 251, 251),
                padding: const EdgeInsets.all(10),
                width: 150,
                height: 100,
                child: const Text('chat room >>>'),
              ),
            ),
          )
,
          //const CreatePost(),
          Center(
            child: ElevatedButton(
              //   child: WebViewExample(),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DonorCard(),
                ),
              ),
              child: Container(
                color: Color.fromARGB(0, 251, 251, 251),
                padding: const EdgeInsets.all(10),
                width: 150,
                height: 100,
                child: const Text('donor card >>>'),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              //   child: WebViewExample(),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => test_page(),
                ),
              ),
              child: Container(
                color: Color.fromARGB(0, 251, 251, 251),
                padding: const EdgeInsets.all(10),
                width: 150,
                height: 100,
                child: const Text('map test>>>'),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class ImageSliderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: CarouselSlider(
        options: CarouselOptions(),
        items: imgList
            .map((item) => Container(
                  child: Center(
                      child: Image.network(item, fit: BoxFit.cover, width: 1000,
                          errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0XFF2156),
                      alignment: Alignment.center,
                      child: const Text(
                        'Poor network!!!',
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  })),
                ))
            .toList(),
      )),
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class ComplicatedImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complicated image slider demo')),
      body: Container(
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: imageSliders,
        ),
      ),
    );
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
        height: 80,
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

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu),
                    SizedBox(
                      width: 160.0,
                    ),
                    Icon(Icons.qr_code),
                    Icon(Icons.notification_add),
                  ],
                ),
                ListTile(
                  title: const Text(
                    'Welcome home',
                    style: TextStyle(color: Colors.white54),
                  ),
                  subtitle: const Text(
                    'Batricia Salfiora',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  trailing: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset('images/mark.jpg'),
                  ),
                ),
                ListTile(
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
                  title: const Text(
                    '28 blood bag',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'The total blood you donate',
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: const ListTile(
                        title: Text(
                          'Its time to donor!',
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
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
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
                  Container(
                    height: 250,
                    width: 120.0,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/rafiki.png"),
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
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: const Card(
                            child: Icon(
                              Icons.search,
                              color: Colors.yellowAccent,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, bottom: 20),
                          child: const Text(
                            'Find\nPatient',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
            ),
          ),
        ],
      ),
    );
  }
}
