import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserNotification extends StatefulWidget {
  @override
  _UserNotificationState createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {
  final Stream<QuerySnapshot> _notificationStream =
      FirebaseFirestore.instance.collection('bloodrequests').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _notificationStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['contact']),
              subtitle: Text(data['note']),
              trailing: Text(data['location']),
            );
          }).toList(),
        );
      },
    );
  }
}
