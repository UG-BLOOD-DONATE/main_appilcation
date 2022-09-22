import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  User currentUser;
  Upload({super.key, required this.currentUser});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  ImagePicker _picker = ImagePicker();
  File? file;

  handleChooseFromGalley() async {
    Navigator.pop(context);
    var image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {});
    file = File(image!.path);
  }

  handleTakePhoto() async {
    Navigator.pop(context);
    var image = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {});
    file = File(image!.path);
  }

  selectImage(parentcontext) {
    return showDialog(
        context: parentcontext,
        builder: ((context) {
          return SimpleDialog(
            title: const Text('Create post'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: handleTakePhoto(),
                child: const Text('Photo with camera'),
              ),
              SimpleDialogOption(
                onPressed: handleChooseFromGalley(),
                child: const Text('Photo with Gallery'),
              ),
              SimpleDialogOption(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        }));
  }

  Container buildSplashScreen() {
    return Container(
      color: Colors.pinkAccent,
      child: Column(children: [
        Image.asset(
          'assets/images/camera.png',
          height: 260.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context, rootNavigator: true)
                .pop(selectImage(context)),
            child: const Text('Uplode image'),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? buildSplashScreen() : buildUploadScreen();
  }

  Scaffold buildUploadScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: clearImage(),
        ),
        title: Text(
          'Caption post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Post",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView(children: <Widget>[
        Container(
          height: 220.0,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: FileImage(file!))),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage:
                CachedNetworkImageProvider(widget.currentUser.photoURL!),
          ),
          title: Container(
            width: 250,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Write a Caption....",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.pin_drop, color: Colors.orange, size: 35.0),
          title: Container(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Location',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Container(
          width: 200.0,
          height: 100.0,
          alignment: Alignment.center,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.my_location),
            label: Text(
              'get current loc',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }

  clearImage() {
    setState(() {
      file = null;
    });
  }
}
