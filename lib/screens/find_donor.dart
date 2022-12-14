import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/components/custom_card.dart';
import 'package:ug_blood_donate/components/custom_image.dart';
import 'package:ug_blood_donate/models/user_model.dart';
import 'package:ug_blood_donate/screens/doner_profile.dart';

class FindDonor extends StatefulWidget {
  @override
  State<FindDonor> createState() => _FindDonorState();
}

class _FindDonorState extends State<FindDonor> {
  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel(groups: []);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Raleway',
          textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2:
                  TextStyle(fontSize: 14.0, fontWeight: FontWeight.w900)),
          brightness: Brightness.light,
          primaryColor: Colors.pink),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text("Find Donors"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: db.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: snapshot.data!.docs.map((doc) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DonerProfilePage(
                          documentId: doc['uid'],
                        ),
                      ),
                    ),
                    child: Card(
                      shadowColor: Colors.white,
                      borderOnForeground: true,
                      elevation: 10.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        // leading: Center(
                        //   child: loggedInUser.photoURL == null
                        //       ? const Icon(
                        //           Icons.person,
                        //           color: Colors.white,
                        //           size: 20,
                        //         )
                        //       : ClipRRect(
                        //           borderRadius: BorderRadius.circular(9.0),
                        //           child: Image.network(loggedInUser.photoURL!),
                        //         ),
                        // ),
                        leading: CustomImage(
                          imageUrl: doc['photoURL'],
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                        ),
                        title: Text(doc['fullname']),
                        subtitle: Text(doc['location']),
                        trailing: Text(doc['bloodType']),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ug_blood_donate/home.dart';

// class FindDonor extends StatefulWidget {
//   @override
//   _FindDonorState createState() => _FindDonorState();
// }

// class _FindDonorState extends State<FindDonor> {
//   late User currentUser;
//   final Stream<QuerySnapshot> _DonorStream = FirebaseFirestore.instance
//       .collection("users")
//       .snapshots(includeMetadataChanges: true);

//   @override
//   Widget build(BuildContext context) {
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       if (user == null) {
//         print("no user in");
//       } else {
//         currentUser = user;
//         print("user in");
//       }
//     });
//     return Scaffold(
//       body: Column(
//         children: [
//           ListTile(
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, size: 32.0),
//               onPressed: () => Navigator.push(
//                 context, //true
//                 MaterialPageRoute(
//                   builder: (_) => Home(
//                     currentUser: currentUser,
//                   ),
//                 ),
//               ),
//             ),
//             title: const Text(
//               "Create A Request",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//           ),
//           StreamBuilder(
//             stream: _DonorStream,
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return const Center(child: Text('Something went wrong'));
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: Text("Loading"));
//               }

//               return ListView(
//                 children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                   Map<String, dynamic> data =
//                       document.data()! as Map<String, dynamic>;
//                   return ListTile(
//                     title: Text(data['fullname']),
//                     subtitle: Text(data['location']),
//                     trailing: Text(data['bloodType']),
//                   );
//                 }).toList(),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
