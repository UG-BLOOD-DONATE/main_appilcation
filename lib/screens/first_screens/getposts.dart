import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ug_blood_donate/components/buttom_navigation_left_button.dart';
import 'package:ug_blood_donate/screens/first_screens/second_screen.dart';
import 'package:ug_blood_donate/screens/home_screen.dart';
import 'package:ug_blood_donate/screens/upload.dart';

class displayposts extends StatefulWidget {
  displayposts({super.key});

  @override
  State<displayposts> createState() => _displaypostsState();
}

class _displaypostsState extends State<displayposts> {
  String? description;
  String? image;
  String? profilepic;
  String? username;
  String? postId;
  String? ownerId;

  int likeCount = 0;
  Map likes = {};
  bool isLiked = false;

  //  retrieveSubPosts() {
  //   FirebaseFirestore.instance.collection("users").get().then((value) {
  //     value.docs.forEach((result) {
  //       FirebaseFirestore.instance
  //           .collection("posts")
  //           .doc(result.id)
  //           .collection("userPosts")
  //           .get()
  //           .then((subcol) {
  //         subcol.docs.forEach((element) {
  //           print(element.data());
  //         });
  //       });
  //     });
  //   });
  // }

  // final Stream<QuerySnapshot> _postStream = FirebaseFirestore.instance
  //     .collection('posts')
  //     .doc(loggedInUser.uid)
  //     .collection('userPosts')
  //     .snapshots();

  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     loggedInUser = UserModel.fromMap(value.data());
  //     //print('hi user');
  //     setState(() {});
  //   });
  // }
  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();
   
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>   LeftButton()),
  );
           
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.navigate_before_rounded),
          //   tooltip: 'Back Icon',
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ), //IconButton
          IconButton(
            icon: const Icon(Icons.add_a_photo_outlined),
            tooltip: 'add a photo',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Upload(
                    currentUser: FirebaseAuth.instance.currentUser!,
                  ),
                ),
              );
              // Upload();
            },
          ), //IconButton
        ], //<Widget>[]
        backgroundColor: Colors.pinkAccent[400],
        elevation: 50.0,
        leading: IconButton(
          icon: const Icon(Icons.navigate_before_rounded),
          tooltip: 'Menu Icon',
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            // .collection('posts')
            // .doc(FirebaseAuth.instance.currentUser!.uid)
            .collectionGroup('userPosts')
            // .orderBy("createdOn", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: const Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return listOfTweets(
                      description = data["description"],
                      image = data["mediaUrl"],
                      profilepic = data["profilepic"],
                      username = data["username"],
                      postId = data["postId"],
                      ownerId = data["ownerId"]);
                })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }

  // void retrieveSubPosts() {
  //   FirebaseFirestore.instance.collection("users").get().then((value) {
  //     value.docs.forEach((result) {
  //       FirebaseFirestore.instance
  //           .collection("posts")
  //           .doc(result.id)
  //           .collection("userPosts")
  //           .get()
  //           .then((subcol) {
  //         subcol.docs.forEach((element) {
  //           print(element.data());
  //         });
  //       });
  //     });
  //   });
  // }

  Widget listOfTweets(
      description, image, profilepic, username, param4, param5) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetAvatar(profilepic),
          tweetBody(description, image),
        ],
      ),
    );
  }

  Widget tweetAvatar(profilepic) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(profilepic),
        ));
  }

  Widget tweetBody(String description, String image) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetHeader(username),
          tweetText(description),
          SizedBox(height: 25),
          tweetButtons(image),
          tweetButtons2(),
          Divider(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget tweetHeader(username) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Text(
            "UG Blood Donate",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
        ),
        Text(
          '@ ',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        Text(
          username,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        Text(
          ' ·5m ',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.angleDown,
            size: 14.0,
            color: Colors.grey,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget tweetText(String description) {
    return Text(
      description,
      overflow: TextOverflow.clip,
    );
  }

  Widget tweetButtons(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget tweetButtons2() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                print("uuuuuuuuuuu");
                handleLikePost(ownerId, postId!);
              },
              child: tweetIconButton(FontAwesomeIcons.heart, '')),
          tweetIconButton(FontAwesomeIcons.comment, ''),
          tweetIconButton(FontAwesomeIcons.retweet, ''),
          tweetIconButton(FontAwesomeIcons.share, ''),
        ],
      ),
    );
  }

  Widget tweetIconButton(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.0,
          color: Colors.black45,
        ),
        Container(
          margin: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }

  handleLikePost(String? ownerId, String postId) {
    bool _isLiked = likes[FirebaseAuth.instance.currentUser!.uid] == true;

    if (_isLiked) {
      FirebaseFirestore.instance
          .collection("posts")
          .doc(ownerId)
          .collection("userPosts")
          .doc(postId)
          .set({'likes.$FirebaseAuth.instance.currentUser!.uid': false});
      setState(() {
        likeCount -= 1;
        isLiked = false;
        likes[FirebaseAuth.instance.currentUser!.uid] = false;
      });
    } else if (!_isLiked) {
      FirebaseFirestore.instance
          .collection("posts")
          .doc(ownerId)
          .collection("userPosts")
          .doc(postId)
          .update({'likes.$FirebaseAuth.instance.currentUser!.uid': true});
      setState(() {
        likeCount += 1;
        isLiked = true;
        likes[FirebaseAuth.instance.currentUser!.uid] = true;
      });
    }
  }
}
