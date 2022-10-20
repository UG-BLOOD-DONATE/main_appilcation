import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/screens/chat/chartpage.dart';
import 'package:ug_blood_donate/screens/donorcard.dart';
import 'package:ug_blood_donate/screens/find_donor.dart';
import 'package:ug_blood_donate/screens/map/order_traking_page.dart';
import 'package:ug_blood_donate/screens/profile.dart';
import 'package:ug_blood_donate/screens/request_blood.dart';
import 'package:ug_blood_donate/screens/view_image.dart';
import 'package:ug_blood_donate/utils/firebase.dart';

import '../models/user_model.dart';
import '../posts/get_nofications.dart';

//import 'package:particles_flutter/particles_flutter.dart';
final List<String> imgList = [
  'https://firebasestorage.googleapis.com/v0/b/ug-blood-donate.appspot.com/o/post_eb5d2cba-2460-4daf-b31d-5b23c0edaba1.jpg?alt=media&token=28e19899-ea81-4a4c-95c9-394b29d41167'
      'https://firebasestorage.googleapis.com/v0/b/ug-blood-donate.appspot.com/o/post_7f9ac525-95b2-4a14-9a35-2f6093444b62.jpg?alt=media&token=f0b720fb-6fac-453e-9153-87d639a09ca8',
  'https://firebasestorage.googleapis.com/v0/b/ug-blood-donate.appspot.com/o/post_11060b04-e842-414a-9c65-ac38fb815c29.jpg?alt=media&token=4d7bfffe-c1d9-4263-9967-e386897862bc',
  'https://firebasestorage.googleapis.com/v0/b/ug-blood-donate.appspot.com/o/post_b133f593-1e1e-4f67-82b2-e588a06e1d03.jpg?alt=media&token=0d896c56-add4-4e78-b237-de795244b25c',
  'https://firebasestorage.googleapis.com/v0/b/ug-blood-donate.appspot.com/o/post_7f9ac525-95b2-4a14-9a35-2f6093444b62.jpg?alt=media&token=f0b720fb-6fac-453e-9153-87d639a09ca8'
];

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
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 248, 2, 76),
          body: SingleChildScrollView(
            child: Stack(children: [
              CircularParticle(
                width: w,
                height: h,
                awayRadius: w / 5,
                numberOfParticles: 90,
                speedOfParticles: 0.5,
                maxParticleSize: 7,
                particleColor:
                    Color.fromARGB(255, 255, 255, 255).withOpacity(.7),
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
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DonorCard(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.qr_code,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(
                        width: 190.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DonorCard(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.notification_add,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                  const ListTile(
                    // leading: Image.network(''),
                    title: Text(
                      'Welcome ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'To UgBlood Donate',
                      //'${currentUser.fullname}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 700,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0))),
                    child: Stack(
                      children: [
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
                              child: ListTile(
                                  title: const Text(
                                    'Its time to donate Blood!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: const Text(
                                      'Click to find the available Donation Centres!'),
                                  trailing: GestureDetector(
                                    onTap: () {
                                       Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MapPage()
                      ),
                    );
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.pink,
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 20.0,
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
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              '    Services',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
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
                                  cardChild: icondata(
                                      label: ' Request', icon: Icons.bloodtype),
                                  page: Request(),
                                ),
                                mycard(
                                  cardChild: icondata(
                                      label: 'Campaign',
                                      icon: Icons.campaign_outlined),
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
                                      label: 'Assistant',
                                      icon: Icons.assistant_navigation),
                                  page: ChatPage(
                                    title: 'Assistant',
                                  ),
                                ),
                                mycard(
                                  cardChild: icondata(
                                      label: 'Centres',
                                      icon: Icons.map_outlined),
                                  page: MapPage(),
                                  //OrderTrackingPage(),
                                ),
                                mycard(
                                  cardChild: const icondata(
                                      label: 'Report', icon: Icons.report),
                                  page: ProfilePage(
                                      userId: widget.currentUser!.uid),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          )),
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

class MovieCard extends StatelessWidget {
  String path = "images/svgs/yts_logo.svg";
  int ratings = 2;
  MovieCard({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 3),
      width: 200,
      height: 300,
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 12,
            child: SvgPicture.asset(
              path,
              fit: BoxFit.fill,
              width: 100,
              height: 100,
            ),
          ),
          //title
          SizedBox(
            height: 5,
          ),
          Text("title",
              style: TextStyle(
                  fontFamily: 'open_sans',
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.normal)),
          IconTheme(
            data: IconThemeData(
              color: Colors.amber,
              size: 20,
            ),
            child: _provideRatingBar(3),
          )
          //ratings
        ],
      ),
    );
  }

  _provideRatingBar(int rating) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return Icon(
            index < rating ? Icons.star : Icons.star_border,
          );
        }));
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
        margin: const EdgeInsets.all(10),
        height: 110,
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
