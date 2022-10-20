import 'dart:io';

//import 'package:alan_voice/alan_voice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ug_blood_donate/components/custom_card.dart';
import 'package:ug_blood_donate/models/user_model.dart';
import 'package:ug_blood_donate/screens/first_screens/LoginRegister.dart';
import 'package:ug_blood_donate/utils/firebase.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

//File? _image;
final picker = ImagePicker();

class ProfilePage extends StatefulWidget {
  String? userId;
  ProfilePage({Key? key, this.userId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with RouteAware {
  /// Subscribe to RouteObserver
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    setVisuals("profile");
  }

  @override
  void didPop() {
    setVisuals("first");
  }

  void setVisuals(String screen) {
    var visual = "{\"screen\":\"$screen\"}";
    //AlanVoice.setVisualState(visual);
  }

  currentUserId() {
    print("${firebaseAuth.currentUser?.uid}");
    return firebaseAuth.currentUser?.uid;
  }

  final _db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel(groups: []);
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  String profilePicLink = "";
  var name;
  var pic;
  var loc;
  var blood;
  var pnum;
  String? fullname = "";
  String? location = "";
  String? bloodType = "";
  String? photoUrl = "";

  void pickUploadProfilePic({String? userId}) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${widget.userId}/images")
        .child("post_$postID");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      loggedInUser.photoURL = value.toString();
      await _db.collection("users").doc("${widget.userId}").update({
        'photoURL': loggedInUser.photoURL,
        // SetOptions(
        //   merge: true,
        // ),
      });
      setState(() {
        profilePicLink = value;
        loggedInUser.photoURL = value.toString();
      });
    });
    print(profilePicLink);
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      //print('hi user');
      if (value.exists) {
        setState(() {
          fullname = value.data()!["fullname"];
          location = value.data()!["location"];
          photoUrl = value.data()!["photoURL"];
          bloodType = value.data()!["bloodType"];
        });
      }
    });
  }

openwhatsapp() async{
  var whatsapp ="+256756322224";
  var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
  var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello download the blood donation mobile application to save a life.")}";
  if(Platform.isIOS){
    // for iOS phone only
    if( await canLaunch(whatappURL_ios)){
       await launch(whatappURL_ios, forceSafariVC: false);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp no installed")));

    }

  }else{
    // android , web
    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp not installed")));

    }


  }
  

}
// Future<void> share() async {
//     await FlutterShare.share(
//         title: 'invite a friend',
//         text: 'Download the blood donate Ug application to get blood donation updates',
//         linkUrl: 'https://ug-blood-donate.github.io/',
//         chooserTitle: 'Blood donation Uganda');
//   }

  _onShareWithEmptyFields(BuildContext context) async {
  await Share.share("text");
}
  @override
  Widget build(BuildContext context) {
    var g = currentUserId();
    // return FutureBuilder<DocumentSnapshot>(
    //     future: users.doc(currentUserId()).get(),
    //     builder:
    //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //       Map<String, dynamic> data =
    //           snapshot.data!.data() as Map<String, dynamic>;
    //       name = data['fullname'];
    //       blood = data['bloodType'];
    //       loc = data['location'];
    //       pic = data['photoURL'];
    //       pnum = data['phonenumber'];
    //       if (snapshot.hasError) {
    //         return Text("Something went wrong");
    //       }

    //       if (snapshot.hasData && !snapshot.data!.exists) {
    //         return Text("Document does not exist");
    //       }

    //       if (snapshot.connectionState == ConnectionState.done) {
    //         Map<String, dynamic> data =
    //             snapshot.data!.data() as Map<String, dynamic>;
    //         name = data['fullname'];
    //         blood = data['bloodType'];
    //         loc = data['location'];
    //         pic = data['photoURL'];
    //         pnum = data['phonenumber'];

    //return Text("loading");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.navigate_before_sharp,
              color: Colors.black,
              size: 24.0,
            ),
          ),
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.edit_note_sharp,
                color: Colors.black,
              ),
              onPressed: () {
                // Navigator.pop(context);
              },
            )
          ],
          //foregroundColor: Colors.black,
          //backgroundColor: Colors.white,
        ), // body is the majority of the screen.
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 34,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: GestureDetector(
                      onDoubleTap: () {
                        pickUploadProfilePic(userId: currentUserId());
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(120, 5, 40, 24),
                        height: 120,
                        width: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: primary,
                        ),
                        child: Center(
                          child: photoUrl == null
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 80,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(photoUrl!),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    /*1*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*2*/
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                          child: Text(
                            fullname!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*3*/
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.pink[500]),
                  Text(
                    location!,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    /*1*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.contact_phone,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                label: const Text('Fund events'),
                                onPressed: () {
                                  _launchURLApp();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(190, 68, 219, 30)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    /*1*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.navigate_before_sharp,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                label: const Text('Donate Cash'),
                                onPressed: () {
                                  _launchURLApp();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 233, 10, 103)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                      width: 105,
                      height: 100,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              bloodType!,
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Blood Type',
                              style:
                                  TextStyle(fontSize: 8, color: Colors.black),
                            ),
                          ))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    /*1*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 100,
                            height: 105,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                                child: const ListTile(
                                  title: Text(
                                    '05',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Donated',
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.black),
                                  ),
                                ))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    /*1*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 100,
                            height: 110,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                                child: const ListTile(
                                  title: Text(
                                    '02',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Flexible(
                                    child: Text(
                                      'Requested',
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black),
                                    ),
                                  ),
                                )))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: Container(
                  height: 60,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.pink,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        /*1*/
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              'Available for donate',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      /*3*/
                      Icon(
                        Icons.toggle_on,
                        color: Colors.pink[500],
                        size: 50,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                child: GestureDetector(
                  onTap: () {
                    Share.share('Download the UG blood donate app: https://ug-blood-donate.github.io/', subject: 'lets save life.');
                   // share();
                    //openwhatsapp();
                  },
                  child: Container(
                    height: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.messenger, color: Colors.pink[500]),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Invite a friend",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                child: GestureDetector(
                  onTap: () {
                    openwhatsapp();
                  },
                  child: Container(
                    height: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.info, color: Colors.pink[500]),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Get help",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                child: Container(
                  height: 60,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.logout_rounded, color: Colors.pink[500]),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomCard(
                        onTap: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text('Log out'),
                                  content: Text('Murife dont run dooont run?'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No')),
                                    TextButton(
                                      onPressed: () {
                                        firebaseAuth.signOut();
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (_) =>
                                                    const Frist_Home()));
                                      },
                                      child: Text('Yes'),
                                    )
                                  ],
                                );
                              });
                        },
                        child: const Text(
                          "Sign Out",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));

    // return Scaffold(
    //   body: Container(
    //     child: CircularProgressIndicator(
    //       color: Colors.pink,
    //     ),
    //   ),
    // );
  }
}

//   Future<void> _upload(String inputSource) async {}
// }
//Paystack intergration function
_launchURLApp() async {
  var url = Uri.parse("https://paystack.com/pay/ugblooddonate");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
//Making a phonecall
_makingPhoneCall() async {
  var url = Uri.parse("tel:9776765434");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
