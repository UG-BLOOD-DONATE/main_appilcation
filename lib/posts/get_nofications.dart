import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserNotification extends StatefulWidget {
  @override
  _UserNotificationState createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {
  String? location;
  String? note;
  String? contact;
  String? pic;

  final Stream<QuerySnapshot> _notificationStream = FirebaseFirestore.instance
      .collection("bloodrequests")
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _notificationStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading"));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return listOfTweets(
                  contact = data['contact'],
                  note = data['note'],
                  location = data['location'],
                  pic = data["photoURL"]);
            }).toList(),
          );
        },
      ),
    );
  }

  Widget listOfTweets(contact, note, location, param3) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetAvatar(),
          tweetBody(note, location),
        ],
      ),
    );
  }

  Widget tweetAvatar() {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(pic!),
        ));
  }

  Widget tweetBody(String description, location) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetHeader(location),
          tweetText(description),
          SizedBox(height: 25),
          tweetButtons(),
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

  Widget tweetButtons() {
    return Text(
      "",
      overflow: TextOverflow.clip,
    );
  }
}
