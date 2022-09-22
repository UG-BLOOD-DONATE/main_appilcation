import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ug_blood_donate/home.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;
import 'package:ug_blood_donate/widgets/indicators.dart';

class Upload extends StatefulWidget {
  User currentUser;
  Upload({super.key, required this.currentUser});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController locationController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? file;
  bool isUploading = false;
  String postId = const Uuid().v4();

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
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: clearImage(),
        ),
        title: const Text(
          'Caption post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          ElevatedButton(
            onPressed: isUploading ? null : () => handleSubmit(),
            child: const Text(
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
        isUploading ? linearProgress(context) : const Text(''),
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
        const Padding(
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
              controller: captionController,
              decoration: InputDecoration(
                hintText: "Write a Caption....",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.pin_drop, color: Colors.orange, size: 35.0),
          title: Container(
            width: 250.0,
            child: TextField(
              controller: locationController,
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
            icon: const Icon(Icons.my_location),
            label: const Text(
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

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    // int rand = new Math.Random().nextInt(10000);
    Im.Image? imageFile = Im.decodeImage(file!.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
    setState(() {
      file = compressedImageFile;
    }); // choose the size here, it will maintain aspect ratio
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(file);
    createPostInFirestore(
      mediaUrl: mediaUrl,
      location: locationController.text,
      description: captionController.text,
    );
  }

  Future<String> uploadImage(imageFile) async {
    UploadTask uploadTask =
        storageRef.child("post_$postId.jpg").putFile(imageFile);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    return imageUrl.toString();
    // UploadTask uploadTask =
    //     storageRef.child("post_$postId.jpg").putFile(imageFile);
    // TaskSnapshot storageSnap = await uploadTask.onComplete;
    // String downloadUrl = await storageSnap.ref.getDownloadURL();
    // return downloadUrl;
  }

  createPostInFirestore(
      {required String mediaUrl,
      required String location,
      required String description}) {}
}
