import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ug_blood_donate/models/user_model.dart';
import 'package:ug_blood_donate/services/services.dart';
import 'package:ug_blood_donate/utils/firebase.dart';

class UserService extends Service {
  //get the authenticated uis
  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }

//tells when the user is online or not and updates the last seen for the messages
  setUserStatus(bool isOnline) {
    var user = firebaseAuth.currentUser;
    if (user != null) {
      usersRef
          .doc(user.uid)
          .update({'isOnline': isOnline, 'lastSeen': Timestamp.now()});
    }
  }

//updates user profile in the Edit Profile Screen
  updateProfile(
      {File? image, String? username, String? bio, String? country}) async {
    DocumentSnapshot doc = await usersRef.doc(currentUid()).get();
    var users = UserModel.fromMap(doc.data() as Map<String, dynamic>);
    users.fullname = username;
    users.email = bio;
    users.location = country;
    // if (image != null) {
    //   users.photoUrl = await uploadImage(profilePic, image);
    // }
    await usersRef.doc(currentUid()).update({
      'fullname': username,
      'email': bio,
      'location': country,
      //"photoUrl": users.photoUrl ?? '',
    });

    return true;
  }
}
