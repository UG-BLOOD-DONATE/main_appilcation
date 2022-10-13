import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Create_post extends StatefulWidget {
  const Create_post({super.key});

  @override
  State<Create_post> createState() => _Create_postState();
}

class _Create_postState extends State<Create_post> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Image Picker Example"),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    File? image;
                    Future pickImage() async {
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        final imageTemp = File(image.path);
                        setState(() => this.image = imageTemp);
                      } on PlatformException catch (e) {
                        print('Failed to pick image: $e');
                      }
                    }
                  }),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    File? image;
                    Future pickImage() async {
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        final imageTemp = File(image.path);
                        setState(() => this.image = imageTemp);
                      } on PlatformException catch (e) {
                        print('Failed to pick image: $e');
                      }
                    }
                  }),
            ],
          ),
        ));
  }
}
















// // ignore_for_file: library_private_types_in_public_api

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:provider/provider.dart';
// import 'package:ug_blood_donate/components/custom_image.dart';
// import 'package:ug_blood_donate/models/user_model.dart';
// import 'package:ug_blood_donate/utils/firebase.dart';
// import 'package:ug_blood_donate/view_models/auth/posts_view_model.dart';
// import 'package:ug_blood_donate/widgets/indicators.dart';

// class CreatePost extends StatefulWidget {
//   const CreatePost({super.key});

//   @override
//   _CreatePostState createState() => _CreatePostState();
// }

// class _CreatePostState extends State<CreatePost> {
//   @override
//   Widget build(BuildContext context) {
//     currentUserId() {
//       return firebaseAuth.currentUser!.uid;
//     }

//     PostsViewModel viewModel = Provider.of<PostsViewModel>(context);
//     return WillPopScope(
//       onWillPop: () async {
//         await viewModel.resetPost();
//         return true;
//       },
//       child: LoadingOverlay(
//         progressIndicator: circularProgress(context),
//         isLoading: viewModel.loading,
//         child: Scaffold(
//           key: viewModel.scaffoldKey,
//           appBar: AppBar(
//             leading: IconButton(
//               icon: const Icon(Ionicons.close_outline),
//               onPressed: () {
//                 viewModel.resetPost();
//                 Navigator.pop(context);
//               },
//             ),
//             title: Text('WOOBLE'.toUpperCase()),
//             centerTitle: true,
//             actions: [
//               GestureDetector(
//                 onTap: () async {
//                   await viewModel.uploadPosts(context);
//                   Navigator.pop(context);
//                   viewModel.resetPost();
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Text(
//                     'Post'.toUpperCase(),
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15.0,
//                       color: Theme.of(context).colorScheme.secondary,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           body: ListView(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             children: [
//               const SizedBox(height: 15.0),
//               StreamBuilder(
//                 stream: usersRef.doc(currentUserId()).snapshots(),
//                 builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//                   if (snapshot.hasData) {
//                     UserModel user = UserModel.fromMap(
//                       snapshot.data!.data() as Map<String, dynamic>,
//                     );
//                     return ListTile(
//                       leading: const CircleAvatar(
//                         radius: 25.0,
//                         //backgroundImage: NetworkImage(user.photoUrl!),
//                       ),
//                       title: Text(
//                         user.fullname!,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(
//                         user.email!,
//                       ),
//                     );
//                   }
//                   return Container();
//                 },
//               ),
//               InkWell(
//                 onTap: () => showImageChoices(context, viewModel),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.width - 30,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(5.0),
//                     ),
//                     border: Border.all(
//                       color: Theme.of(context).colorScheme.secondary,
//                     ),
//                   ),
//                   child: viewModel.imgLink != null
//                       ? CustomImage(
//                           imageUrl: viewModel.imgLink,
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.width - 30,
//                           fit: BoxFit.cover,
//                         )
//                       : viewModel.mediaUrl == null
//                           ? Center(
//                               child: Text(
//                                 'Upload a Photo',
//                                 style: TextStyle(
//                                   color:
//                                       Theme.of(context).colorScheme.secondary,
//                                 ),
//                               ),
//                             )
//                           : Image.file(
//                               viewModel.mediaUrl!,
//                               width: MediaQuery.of(context).size.width,
//                               height: MediaQuery.of(context).size.width - 30,
//                               fit: BoxFit.cover,
//                             ),
//                 ),
//               ),
//               const SizedBox(height: 20.0),
//               Text(
//                 'Post Caption'.toUpperCase(),
//                 style: const TextStyle(
//                   fontSize: 15.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               TextFormField(
//                 initialValue: viewModel.description,
//                 decoration: const InputDecoration(
//                   hintText: 'Eg. This is very beautiful place!',
//                   focusedBorder: UnderlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 onChanged: (val) => viewModel.setDescription(val),
//               ),
//               const SizedBox(height: 20.0),
//               Text(
//                 'Location'.toUpperCase(),
//                 style: const TextStyle(
//                   fontSize: 15.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               ListTile(
//                 contentPadding: const EdgeInsets.all(0.0),
//                 title: SizedBox(
//                   width: 250.0,
//                   child: TextFormField(
//                     controller: viewModel.locationTEC,
//                     decoration: const InputDecoration(
//                       contentPadding: EdgeInsets.all(0.0),
//                       hintText: 'Kampala,Uganda!',
//                       focusedBorder: UnderlineInputBorder(),
//                     ),
//                     maxLines: null,
//                     onChanged: (val) => viewModel.setLocation(val),
//                   ),
//                 ),
//                 trailing: IconButton(
//                   tooltip: "Use your current location",
//                   icon: const Icon(
//                     CupertinoIcons.map_pin_ellipse,
//                     size: 25.0,
//                   ),
//                   iconSize: 30.0,
//                   color: Theme.of(context).colorScheme.secondary,
//                   onPressed: () => viewModel.getLocation(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   showImageChoices(BuildContext context, PostsViewModel viewModel) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       builder: (BuildContext context) {
//         return FractionallySizedBox(
//           heightFactor: .6,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20.0),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Text(
//                   'Select Image',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const Divider(),
//               ListTile(
//                 leading: const Icon(Ionicons.camera_outline),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   viewModel.pickImage(camera: true);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Ionicons.image),
//                 title: const Text('Gallery'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   viewModel.pickImage();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
