import 'package:get/get.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_geofence/geofence.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';

class GeofenceController extends GetxController {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Geoflutterfire geo = Geoflutterfire();

  static LatLng _initialPosition = LatLng(0.339535, 32.571199);
  static Geolocation? _location;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  void Geofencesintialize() {
    for(int i=1;i>0;i++){
      final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('Geofences').snapshots();
        // Create a geoFirePoint
GeoFirePoint center = geo.point(latitude: 12.960632, longitude: 77.641603);

// get the collection reference or query
var collectionReference = _firestore.collection('Geofences');

double radius = 50;
String field = 'lati';

Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef: collectionReference)
                                        .within(center: center, radius: radius, field: field);

    }
  
  
    // StreamBuilder<QuerySnapshot>(
    //     stream: _usersStream,
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (snapshot.hasError) {
    //         return const Text('Something went wrong');
    //       }
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         //return Scaffold(body: const Text("Loading"));
    //       }

    //     });
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Geofences').snapshots();

  void removeGeoFenceLocation() {
    if (_location != null) {
      Geofence.removeGeolocation(_location!, GeolocationEvent.entry);
    }
  }

  Future<void> _listenForPersmissionStatus() async {
    try {
      final _status = await Permission.locationWhenInUse.serviceStatus;

      if (_status.isEnabled) {
        print("permission granted");
        _getUserLocation();
      } else {
        print("permission denied");
      }
    } catch (error) {
      print("get permission status error: $error");
    }
  }

  Future<void> _initPlatformState() async {
    Geofence.initialize();

    Geofence.startListening(GeolocationEvent.entry, (entry) {
      _scheduleNotification("There is a blood donation Centre nearby",
          "Open Centre then tap: ${entry.id}");
    });

    Geofence.startListening(GeolocationEvent.exit, (entry) {
      _scheduleNotification("Outside GeoFence", "Byebye to: ${entry.id}");
    });
  }

  Future<void> _getUserLocation() async {
    try {
      final Coordinate? userLoc = await Geofence.getCurrentLocation();

      _initialPosition = LatLng(userLoc!.latitude, userLoc.longitude);
    } catch (error) {
      print("Error get current location");
    }
  }

  // void _setGeofenceRegion(LatLng geofenceMarkerLatLng, String placename) {
  //   _location = Geolocation(
  //     id: "$placename",
  //     latitude: geofenceMarkerLatLng.latitude,
  //     longitude: geofenceMarkerLatLng.longitude,
  //     radius: _initRadius,
  //   );
  //   String name = placename;
  //   Geofence.addGeolocation(
  //     _location!,
  //     GeolocationEvent.entry,
  //   ).then((value) {
  //     // _scheduleNotification(
  //     //     "Blood Donation Centre Added", "centre has been added at $name");
  //     // print("Georegion added");
  //   }).catchError((error) {
  //     // print("Added geofence failed, $error");
  //   });
  // }

  void _scheduleNotification(String title, String subtitle) {
    Future.delayed(Duration(seconds: 5)).then((result) async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        icon: "launch_background",
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

      var iOSPlatformChannelSpecifics = DarwinNotificationDetails();

      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.show(
        0,
        title,
        subtitle,
        platformChannelSpecifics,
        payload: 'you clicked the notfication',
      );
    });
  }
}
