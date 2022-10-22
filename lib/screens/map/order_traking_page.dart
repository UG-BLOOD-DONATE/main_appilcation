
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'dart:io' show Platform;

import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

//import 'package:ug_blood_donate/Chatsection/widgets/widgets.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with WidgetsBindingObserver {
  String event = "";
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late Geoflutterfire geo;
  final myController = TextEditingController();
  String placename = 'Centre';
  late Stream<List<DocumentSnapshot>> stream;

  static LatLng _geofenceMarkerPosition = LatLng(0, 0);
  static double _initRadius = 1000.0;
  //DatabaseReference ref = FirebaseDatabase.instance.ref();
  static LatLng _initialPosition = LatLng(0, 0);

  static Geolocation? _location;

  Completer<GoogleMapController> _controller = Completer();
  //Geoflutterfire geo = Geoflutterfire();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Set<Marker> _markers = {};
  String _platformVersion = Platform.isAndroid ? "Android" : "ios";
  String _userStatus = "None";
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Geofences').snapshots();

  @override
  void didUpdateWidget(MapPage oldWidget) {
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

  void addmarkesmult() {}

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

//LatLng position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    Geofence.startListening(GeolocationEvent.entry, (entry) {
      _scheduleNotification("Inside GeoFence", "Welcome to: ${entry.id}");
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

  // void getData() {
  //   FirebaseFirestore.instance.collection("stores").get().then((value) {
  //     value.docs.forEach((f) {
  //       print('${f.data}}');
  //       GeoPoint pos = f.data() as GeoPoint;
  //       LatLng latLng = new LatLng(pos.latitude, pos.longitude);
  //       print('${latLng}');
  //     });
  //   });
  // }

  void _printLatestValue() {}

  @override
  Widget build(BuildContext context) {
    //getData();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: const Text("Loading"));
        }
        var deviceData = MediaQuery.of(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(239, 52, 83, 0.918),
            title: Text('Donation Centres'),
          ),
          body: ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  double latitude = data['latitude'];
                  double longitude = data['longitude'];
                  LatLng latLng = LatLng(latitude, longitude);
                  return GestureDetector(
                    onTap: () {
                      {
                        print(data['position']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UsersGeoPage(
                                data['name'], latLng, data['radius']),
                          ),
                        );
                      }
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        trailing: Icon(Icons.more_vert),
                        title: Text(
                          data['name'],
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(''),
                      ),
                    ),
                  );
                })
                .toList()
                .cast(),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class UsersGeoPage extends StatefulWidget {
  UsersGeoPage(this.name, this.position, this.radius, {super.key});
//UsersGeoPage({super.key});
  String name;
  LatLng position;
  double radius;
  @override
  _UsersGeoPageState createState() => _UsersGeoPageState();
}

class _UsersGeoPageState extends State<UsersGeoPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Geoflutterfire geo = Geoflutterfire();

  static LatLng _geofenceMarkerPosition = LatLng(0, 0);
  static double _initRadius = 1000;
  static LatLng _initialPosition = LatLng(0.339535, 32.571199);
  static Geolocation? _location;

  Completer<GoogleMapController> _controller = Completer();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formkey = GlobalKey<FormState>();
  Set<Marker> _markers = {};
  String _platformVersion = Platform.isAndroid ? "Android" : "ios";

  @override
  void didUpdateWidget(UsersGeoPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    print("oldwidget $oldWidget");
  }

  @override
  void dispose() {
    super.dispose();
    // WidgetsBinding.instance.removeObserver(this);
    removeGeoFenceLocation();
  }

  @override
  void initState() {
    _geofenceMarkerPosition = widget.position;
    _addMarkerLongPressed(widget.position, widget.name);
    _setGeofenceRegion(widget.position, widget.name);
    _initRadius = widget.radius;
    _initPlatformState();
    super.initState();
    print('${widget.position}');
    //WidgetsBinding.instance.addObserver(this);
    Geofence.requestPermissions();
    _getPolyline();
    //
    //_initPlatformState();

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
      setState(() {});
    });

    Geofence.startListening(GeolocationEvent.exit, (entry) {
      _scheduleNotification("Outside GeoFence", "Byebye to: ${entry.id}");
      setState(() {});
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
      // _scheduleNotification(
      //     "Blood Donation Centre Added", "centre has been added at $name");
      // print("Georegion added");
    }).catchError((error) {
      // print("Added geofence failed, $error");
    });
  }

  Future<void> _addMarkerLongPressed(LatLng latLng, String name) async {
    setState(() {
      _markers = {};
      _geofenceMarkerPosition = latLng;
      Geofence.initialize();

      Geofence.startListening(GeolocationEvent.entry, (entry) {
        _scheduleNotification("There is a blood donation Centre nearby",
            "Just go to: ${entry.id}");
        setState(() {});
      });

      Geofence.startListening(GeolocationEvent.exit, (entry) {
        _scheduleNotification("Outside GeoFence", "Byebye to: ${entry.id}");
        setState(() {});
      });
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

  void _printLatestValue() {}

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    setState(() {});
    Geofence.startListening(GeolocationEvent.entry, (entry) {
      _scheduleNotification(
          "There is a blood donation Centre nearby", "Just go to: ${entry.id}");
      setState(() {});
    });

// ignore_for_file: prefer_const_constructors;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 52, 83, 0.918),
        title: Text('Go to Blood Donation Centre'),
      ),
      body: _initialPosition == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                Container(
                  height: deviceData.size.height,
                  width: deviceData.size.width,
                  child: GoogleMap(
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      tilt: 50,
                      bearing: 145,
                      target: _initialPosition,
                      zoom: 14.4746,
                    ),
                    myLocationEnabled: true,
                    compassEnabled: true,
                    myLocationButtonEnabled: true,
                    tiltGesturesEnabled: false,
                    markers: _markers,
                    circles:
                        // _geofenceMarkerPosition == null
                        //     ? null
                        //     :
                        {
                      Circle(
                        fillColor: ThemeData().primaryColor.withOpacity(0.2),
                        strokeColor: const Color.fromARGB(0, 255, 3, 3),
                        center: _geofenceMarkerPosition,
                        radius: _initRadius,
                        circleId: CircleId(
                          _initialPosition.toString(),
                        ),
                      )
                    },
                    polylines: Set<Polyline>.of(polylines.values),
                  ),
                ),
              ],
            ),
    );
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        width: 5,
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  _getPolyline() async {
    await _getUserLocation();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBfVy6AcTcPKFNbEBMu30Ws7Cj-kc1-yew',
      PointLatLng(_initialPosition.latitude, _initialPosition.longitude),
      PointLatLng(widget.position.latitude, widget.position.longitude),
      travelMode: TravelMode.walking,
      optimizeWaypoints: true,
      //wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
