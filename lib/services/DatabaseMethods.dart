import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  createChatRoom(String charRoomId, chatRoomMap) {
   FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(charRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }
}
