import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? username;
  String? comment;
  Timestamp? timestamp;
  String? userDp;
  String? userId;

  CommentModel({
    this.username,
    this.comment,
    this.timestamp,
    this.userDp,
    this.userId,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    comment = json['comment'];
    timestamp = json['timestamp'];
    userDp = json['userDp'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['comment'] = comment;
    data['timestamp'] = timestamp;
    data['userDp'] = userDp;
    data['userId'] = userId;
    return data;
  }
}
