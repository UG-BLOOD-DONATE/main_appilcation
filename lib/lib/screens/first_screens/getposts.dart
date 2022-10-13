import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ug_blood_donate/home.dart';
import 'package:ug_blood_donate/models/user_model.dart';
import 'package:ug_blood_donate/screens/view_image.dart';
//import 'package:getwidget/getwidget.dart';

class displayposts extends StatefulWidget {
  displayposts({super.key});

  @override
  State<displayposts> createState() => _displaypostsState();
}

class _displaypostsState extends State<displayposts> {
  String? description;
  String? image;
  // User? user = FirebaseAuth.instance.currentUser;
  // UserModel loggedInUser = UserModel(groups: []);
  // void retrievePosts() {
  //   FirebaseFirestore.instance.collection("posts").get().then((value) {
  //     value.docs.forEach((result) {
  //       print(result.data());
  //     });
  //   });
  // }

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
            icon: const Icon(Icons.settings),
            tooltip: 'Setting Icon',
            onPressed: () {},
          ), //IconButton
        ], //<Widget>[]
        backgroundColor: Colors.pinkAccent[400],
        elevation: 50.0,
        leading: IconButton(
          icon: const Icon(Icons.navigate_before_rounded),
          tooltip: 'Menu Icon',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            // .collection('posts')
            // .doc(FirebaseAuth.instance.currentUser!.uid)
            .collectionGroup('userPosts')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return listOfTweets(description = data["description"],
                      image = data["mediaUrl"]);
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

  Widget listOfTweets(String description, String image) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetAvatar(),
          tweetBody(description, image),
        ],
      ),
    );
  }

  Widget tweetAvatar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        backgroundImage: NetworkImage(
            "https://images.wallpapersden.com/image/download/evil-thanos-smile_bGtnbWuUmZqaraWkpJRnamtlrWZpaWU.jpg"),
      ),
    );
  }

  Widget tweetBody(String description, String image) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetHeader(),
          tweetText(description),
          SizedBox(height: 25),
          tweetButtons(image),
        ],
      ),
    );
  }

  Widget tweetHeader() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Text(
            "UG Blood Donate",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          '@thanosak ·5m ',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            Icons.arrow_downward,
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
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        image,
        fit: BoxFit.cover,
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
}
