import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ug_blood_donate/models/user_model.dart';
import 'package:ug_blood_donate/screens/view_image.dart';

class displayposts extends StatefulWidget {
  displayposts({super.key});

  @override
  State<displayposts> createState() => _displaypostsState();
}

class _displaypostsState extends State<displayposts> {
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
                  return ListTile(
                    leading: Image.network(data['mediaUrl']),
                    title: Text(data['description']),
                  );
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
}
