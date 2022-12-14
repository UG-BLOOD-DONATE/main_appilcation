import 'dart:io';

class UserModel {
  String? uid;
  String? email;
  String? fullname;
  String? phonenumber;
  String? bloodType;
  String? location;
  String? photoURL;
  List<String>? groups;

  UserModel(
      {this.uid,
      this.email,
      this.fullname,
      this.phonenumber,
      this.bloodType,
      this.location,
      this.photoURL,
    this.groups
     });
//data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullname: map['fullname'],
      phonenumber: map['phonenumber'],
      bloodType: map['bloodType'],
      location: map['location'],
      photoURL: map['photoURL'],
     groups: map['groups'],
    );
  }

  //get photoUrl => null;
//sending to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'phonenumber': phonenumber,
      'bloodType': bloodType,
      'location': location,
      'photoURL': photoURL,
      'groups': groups,
    };
  }
}
