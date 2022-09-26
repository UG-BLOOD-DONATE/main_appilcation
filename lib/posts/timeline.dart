import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/home.dart';
import 'package:ug_blood_donate/posts/dispay_posts.dart';
import 'package:ug_blood_donate/widgets/indicators.dart';

class Timeline extends StatefulWidget {
  final User currentUser;
  const Timeline({super.key, required this.currentUser});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  late List<Post_display> posts;

  @override
  void initState() {
    super.initState();
    getTimeline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('posts'),
        ),
        body: RefreshIndicator(
            child: buildTimeline(), onRefresh: () => getTimeline()));
  }

  getTimeline() async {
    QuerySnapshot snapshot = await timelineRef
        .doc(widget.currentUser.uid)
        .collection('timelinePosts') //timelinePosts
        .orderBy('timestamp', descending: true)
        .get();
    List<Post_display> posts =
        snapshot.docs.map((doc) => Post_display.fromDocument(doc)).toList();

    setState(() {
      this.posts = posts;
    });
  }

  buildTimeline() {
    if (posts == null) {
      return circularProgress(context);
    } else if (posts.isEmpty) {
      return const Center(child: Text('no posts'));
    } else {
      return ListView(
        children: posts,
      );
    }
  }
}
