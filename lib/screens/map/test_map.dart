import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:ug_blood_donate/Chatsection/widgets/widgets.dart';

class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage>
    with WidgetsBindingObserver {
  String _platformVersion = Platform.isAndroid ? "Android" : "ios";

  Completer<GoogleMapController> _controller = Completer();

  static LatLng _initialPosition = LatLng(0.339535, 32.571199);

  Set<Marker> _markers = {};

  static LatLng _geofenceMarkerPosition = LatLng(0, 0);

  static double _initRadius = 1000.0;

  String placename = 'Centre';
  String _userStatus = "None";
  final _formkey = GlobalKey<FormState>();

  static Geolocation? _location;
  Geoflutterfire geo = Geoflutterfire();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final myController = TextEditingController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String event = "";
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    Geofence.requestPermissions();
    _initPlatformState();

    _listenForPersmissionStatus();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: null,
    );
  }

  @override
  void didUpdateWidget(TrackingPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    print("oldwidget $oldWidget");
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    removeGeoFenceLocation();
    myController.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("resumed");
        _listenForPersmissionStatus();
        break;
      case AppLifecycleState.detached:
        print("detached");
        break;
      case AppLifecycleState.inactive:
        print("inactive");
        removeGeoFenceLocation();
        setState(() {
          _markers = {};
          _geofenceMarkerPosition;
        });
        break;
      case AppLifecycleState.paused:
        print("paused");
        break;
      default:
        print("Lifecycle error occur");
    }
  }

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
    if (!mounted) return;

    Geofence.initialize();

    Geofence.startListening(GeolocationEvent.entry, (entry) {
      _scheduleNotification(
          "There is a blood donation Centre nearby", "Just go to: ${entry.id}");
      setState(() {
        _userStatus = "inside";
      });
    });

    Geofence.startListening(GeolocationEvent.exit, (entry) {
      _scheduleNotification("Outside GeoFence", "Byebye to: ${entry.id}");
      setState(() {
        _userStatus = "outside";
      });
    });

    setState(() {});
  }

  Future _onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Open Map to Navigate to Centre"),
        content: Text("Playload : $payload"),
      ),
    );
  }

  Future<void> _getUserLocation() async {
    try {
      final Coordinate? userLoc = await Geofence.getCurrentLocation();

      setState(() {
        _initialPosition = LatLng(userLoc!.latitude, userLoc.longitude);
      });
    } catch (error) {
      print("Error get current location");
    }
  }

  void _setGeofenceRegion(LatLng geofenceMarkerLatLng, String placename) {
    _location = Geolocation(
      id: "$placename",
      latitude: geofenceMarkerLatLng.latitude,
      longitude: geofenceMarkerLatLng.longitude,
      radius: _initRadius,
    );
    String name = placename;
    Geofence.addGeolocation(
      _location!,
      GeolocationEvent.entry,
    ).then((value) {
      _scheduleNotification(
          "Blood Donation Centre Added", "centre has been added at $name");
      print("Georegion added");
    }).catchError((error) {
      print("Added geofence failed, $error");
    });
    if (name != 'Centre') {
      GeoFirePoint geoFirePoint = geo.point(
          latitude: geofenceMarkerLatLng.latitude,
          longitude: geofenceMarkerLatLng.longitude);
      _firestore.collection('Geofences').add({
        'name': '$name',
        'radius': _initRadius,
        'position': geoFirePoint.data
      }).then((_) {
        print('added ${geoFirePoint.hash} successfully');
      });
    }
  }

  Future<void> _addMarkerLongPressed(LatLng latLng, String name) async {
    setState(() {
      _markers = {};
      _geofenceMarkerPosition = latLng;

      _setGeofenceRegion(_geofenceMarkerPosition, name);

      _markers.add(
        Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId('$name'),
          position: latLng,
          infoWindow: InfoWindow(title: "$name", snippet: "This is snippet"),
          onTap: () {
            setState(() {
              _markers = {};
            });
          },
        ),
      );
    });
  }

  void _scheduleNotification(String title, String subtitle) {
    Future.delayed(Duration(seconds: 5)).then((result) async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        icon: "@mipmap/ic_launcher",
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

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

// ignore_for_file: prefer_const_constructors;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 52, 83, 0.918),
        title: Text('Event Location'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Guideline to create a donation Centre"),
                  content: Text(
                      "Long pressed the area you wanted to place marker, Slider will be appear for you to adjust the geofence ranges"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text("OK"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: _initialPosition == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                Container(
                  height: deviceData.size.height,
                  width: deviceData.size.width,
                  child: GoogleMap(
                    mapType: MapType.hybrid,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 14.4746,
                    ),
                    myLocationEnabled: true,
                    compassEnabled: true,
                    myLocationButtonEnabled: true,
                    tiltGesturesEnabled: false,
                    onLongPress: (latLng) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text(
                              "Enter name of the Blood  Donation Centre"),
                          content: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Form(
                              key: _formkey,
                              child: TextFormField(
                                controller: myController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter name',
                                ),
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        Color.fromRGBO(239, 52, 83, 0.918)),
                                child: const Text("Enter"),
                                onPressed: () {
                                  setState(() {
                                    placename = myController.text;
                                    _addMarkerLongPressed(latLng, placename);
                                    print(placename);
                                  });
                                  if (myController.text != null) {
                                    Navigator.pop(context);
                                  } else {
                                    showSnackbar(
                                        context,
                                        Color.fromRGBO(239, 52, 83, 0.918),
                                        Text('Add Place details'));
                                  }
                                })
                          ],
                        ),
                      );
                    },
                    markers: _markers,
                    circles:
                        // _geofenceMarkerPosition == null
                        //     ? null
                        //     :
                        Set.from(
                      [
                        Circle(
                          fillColor: ThemeData().primaryColor.withOpacity(0.2),
                          strokeColor: const Color.fromARGB(0, 255, 3, 3),
                          center: _geofenceMarkerPosition,
                          radius: _initRadius,
                          circleId: CircleId(
                            _initialPosition.toString(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 30, right: 80, left: 20),
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                                "Geofence area: ${(_initRadius / 100).toStringAsFixed(0)}KM"),
                            Text("Status: $_userStatus")
                          ],
                        ),
                        Center(
                          child: Slider(
                              value: _initRadius,
                              divisions: 5,
                              min: 100,
                              max: 1000,
                              onChangeEnd: (_) {
                                Geofence.removeGeolocation(
                                  _location!,
                                  GeolocationEvent.entry,
                                );
                                // .then((value) {
                                //   // print("Georegion removed");
                                //   _setGeofenceRegion(
                                //       _geofenceMarkerPosition, placename);
                                // });
                              },
                              onChanged: (newValue) {
                                setState(() {
                                  // _scheduleNotification(
                                  //     "Blood Donation Centre ",
                                  //     "Your blood donation centre has been added!");
                                  _initRadius = newValue;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  void _printLatestValue() {}
}

class _showinput {}
