import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ug_blood_donate/screens/map/constants.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  MapType _currentMapType = MapType.normal;
  late GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(0.3272399, 32.57796);
  static const LatLng destination = LatLng(0.312222, 32.585556);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  void getcurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) => currentLocation = location);
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((newlock) {
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              tilt: 0.0,
              zoom: 17.5,
              target: LatLng(newlock.latitude!, newlock.longitude!))));
      setState(() {});
    });
  }

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
    }
    setState(() {});
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_source.png")
        .then((icon) => sourceIcon = icon);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_destination.png")
        .then((icon) => destinationIcon = icon);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Badge.png")
        .then((icon) => currentLocationIcon = icon);
  }

  @override
  void initState() {
    getcurrentLocation();
    setCustomMarkerIcon();
    // getPolyPoints();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getcurrentLocation();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back, size: 32.0),
          onPressed: () => Navigator.pop(context, true),
        ),
        title: const Text(
          "View Donor",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: currentLocation == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 8,
                  ),
                  Text('Loading'),
                ],
              ),
            )
          : Stack(children: <Widget>[
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                compassEnabled: true,
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                    tilt: 9.0,
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    zoom: 10.5),
                markers: {
                  Marker(
                    markerId: const MarkerId("currentLocation"),
                    // icon: currentLocationIcon,
                    position: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                  ),
                  // Marker(
                  //   markerId: MarkerId("source"),
                  //   icon: sourceIcon,
                  //   position: sourceLocation,
                  // ),
                  // Marker(
                  //   icon: destinationIcon,
                  //   markerId: MarkerId("destination"),
                  //   position: destination,
                  // ),
                },
                // polylines: {
                //   Polyline(
                //     polylineId: PolylineId("route"),
                //     points: polylineCoordinates,
                //     color: primaryColor,
                //     width: 5,
                //   ),
                // },
              ),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: FloatingActionButton(
              //       onPressed: () {
              //         _onMapTypeButtonPressed;
              //       },
              //       materialTapTargetSize: MaterialTapTargetSize.padded,
              //       backgroundColor: Colors.green,
              //       child: const Icon(Icons.map, size: 36.0),
              //     ),
              //   ),
              // ),
            ]),
    );
  }

  // void _onMapTypeButtonPressed() {
  //   setState(() {
  //     _currentMapType = _currentMapType == MapType.normal
  //         ? MapType.satellite
  //         : MapType.normal;
  //   });
  // }
}

// class TestGoogle extends StatelessWidget {
//   TestGoogle({Key? key}) : super(key: key);

//   late GoogleMapController mapController;
//   Location location = Location();

//   Future<LatLng> get() async {
//     final _locationData = await location.getLocation();
//     return LatLng(_locationData.latitude, _locationData.longitude);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<LatLng>(
//         future: get(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final locationModel = snapshot.data!;
//             final latitude = locationModel.latitude;
//             final longitude = locationModel.longitude;

//             return GoogleMap(
//               myLocationEnabled: true,
//               onCameraMove: (CameraPosition cameraPosition) {
//                 print(cameraPosition.zoom);
//               },
//               initialCameraPosition: CameraPosition(target: locationModel, zoom: 15.0),
//             );
//           }
//           return const CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }
// import 'dart:async';
// import 'dart:io' show Platform;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_geofence/geofence.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:permission_handler/permission_handler.dart';

// class OrderTrackingPage extends StatefulWidget {
//   @override
//   _OrderTrackingPageState createState() => _OrderTrackingPageState();
// }

// class _OrderTrackingPageState extends State<OrderTrackingPage>
//     with WidgetsBindingObserver {
//   String _platformVersion = Platform.isAndroid ? "Android" : "ios";

//   Completer<GoogleMapController> _controller = Completer();

//   static LatLng _initialPosition = LatLng(0, 0);

//   Set<Marker> _markers = {};

//   static LatLng _geofenceMarkerPosition = LatLng(0, 0);

//   static double _initRadius = 1000.0;

//   String _userStatus = "None";

//   static Geolocation? _location;

//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addObserver(this);
//     Geofence.requestPermissions();
//     _initPlatformState();

//     _listenForPersmissionStatus();

// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');

//     var initializationSettingsIOS = DarwinInitializationSettings();

//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: null,
//     );
//   }

//   @override
//   void didUpdateWidget(OrderTrackingPage oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     print("oldwidget $oldWidget");
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     removeGeoFenceLocation();
//   }

//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     switch (state) {
//       case AppLifecycleState.resumed:
//         print("resumed");
//         _listenForPersmissionStatus();
//         break;
//       case AppLifecycleState.detached:
//         print("detached");
//         break;
//       case AppLifecycleState.inactive:
//         print("inactive");
//         removeGeoFenceLocation();
//         setState(() {
//           _markers = {};
//           _geofenceMarkerPosition;
//         });
//         break;
//       case AppLifecycleState.paused:
//         print("paused");
//         break;
//       default:
//         print("Lifecycle error occur");
//     }
//   }

//   void removeGeoFenceLocation() {
//     if (_location != null) {
//       Geofence.removeGeolocation(_location!, GeolocationEvent.entry);
//     }
//   }

//   Future<void> _listenForPersmissionStatus() async {
//     try {
//       final _status = await Permission.locationWhenInUse.serviceStatus;

//       if (_status.isEnabled) {
//         print("permission granted");
//         _getUserLocation();
//       } else {
//         print("permission denied");
//       }
//     } catch (error) {
//       print("get permission status error: $error");
//     }
//   }

//   Future<void> _initPlatformState() async {
//     if (!mounted) return;

//     Geofence.initialize();

//     Geofence.startListening(GeolocationEvent.entry, (entry) {
//       _scheduleNotification("Inside GeoFence", "Welcome to: ${entry.id}");
//       setState(() {
//         _userStatus = "inside";
//       });
//     });

//     Geofence.startListening(GeolocationEvent.exit, (entry) {
//       _scheduleNotification("Outside GeoFence", "Byebye to: ${entry.id}");
//       setState(() {
//         _userStatus = "outside";
//       });
//     });

//     setState(() {});
//   }

//   Future _onSelectNotification(String payload) async {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Here is your payload"),
//         content: Text("Playload : $payload"),
//       ),
//     );
//   }

//   Future<void> _getUserLocation() async {
//     try {
//       final Coordinate? userLoc = await Geofence.getCurrentLocation();

//       setState(() {
//         _initialPosition = LatLng(userLoc!.latitude, userLoc.longitude);
//       });
//     } catch (error) {
//       print("Error get current location");
//     }
//   }

//   void _setGeofenceRegion(LatLng geofenceMarkerLatLng) {
//     _location = Geolocation(
//       id: "luktm",
//       latitude: geofenceMarkerLatLng.latitude,
//       longitude: geofenceMarkerLatLng.longitude,
//       radius: _initRadius,
//     );

//     Geofence.addGeolocation(
//       _location!,
//       GeolocationEvent.entry,
//     ).then((value) {
//       _scheduleNotification(
//           "Geo region added", "Your blood donation centre has been added!");
//       print("Georegion added");
//     }).catchError((error) {
//       print("Added geofence failed, $error");
//     });
//   }

//   Future<void> _addMarkerLongPressed(LatLng latLng) async {
//     setState(() {
//       _markers = {};
//       _geofenceMarkerPosition = latLng;

//       _setGeofenceRegion(_geofenceMarkerPosition!);

//       _markers.add(
//         Marker(
//           icon: BitmapDescriptor.defaultMarker,
//           markerId: MarkerId(_initialPosition.toString()),
//           position: latLng,
//           infoWindow:
//               InfoWindow(title: "Region Set", snippet: "This is snippet"),
//           onTap: () {
//             setState(() {
//               _markers = {};
//             });
//           },
//         ),
//       );
//     });
//   }

//   void _scheduleNotification(String title, String subtitle) {
//     Future.delayed(Duration(seconds: 5)).then((result) async {
//       var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'your channel id',
//         'your channel name',
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker',
//       );

//       var iOSPlatformChannelSpecifics = DarwinNotificationDetails();

//       var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics,
//       );

//       await flutterLocalNotificationsPlugin.show(
//         0,
//         title,
//         subtitle,
//         platformChannelSpecifics,
//         payload: 'you clicked the notfication',
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var deviceData = MediaQuery.of(context);

// ignore_for_file: prefer_const_constructors

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Geofence'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.help_outline),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (_) => AlertDialog(
//                   title: Text("Guideline to use geofence"),
//                   content: Text(
//                       "Long pressed the area you wanted to place marker, Slider will be appear for you to adjust the geofence ranges"),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   actions: <Widget>[
//                     ElevatedButton(
//                       child: Text("OK"),
//                       onPressed: () => Navigator.pop(context),
//                     )
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: _initialPosition == null
//           ? Center(child: CircularProgressIndicator())
//           : Stack(
//               children: <Widget>[
//                 Container(
//                   height: deviceData.size.height,
//                   width: deviceData.size.width,
//                   child: GoogleMap(
//                     mapType: MapType.normal,
//                     onMapCreated: (GoogleMapController controller) {
//                       _controller.complete(controller);
//                     },
//                     initialCameraPosition: CameraPosition(
//                       target: _initialPosition,
//                       zoom: 14.4746,
//                     ),
//                     myLocationEnabled: true,
//                     compassEnabled: true,
//                     myLocationButtonEnabled: true,
//                     tiltGesturesEnabled: false,
//                     onLongPress: (latLng) {
//                       _addMarkerLongPressed(latLng);
//                     },
//                     markers: _markers,
//                     circles:
//                         // _geofenceMarkerPosition == null
//                         //     ? null
//                         //     :
//                         Set.from(
//                       [
//                         Circle(
//                           fillColor: ThemeData().primaryColor.withOpacity(0.2),
//                           strokeColor: Colors.transparent,
//                           center: _geofenceMarkerPosition,
//                           radius: _initRadius,
//                           circleId: CircleId(
//                             _initialPosition.toString(),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 if (_markers.isNotEmpty)
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                       ),
//                       margin: EdgeInsets.only(bottom: 30, right: 80, left: 30),
//                       padding: EdgeInsets.all(20),
//                       width: double.infinity,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: <Widget>[
//                               Text(
//                                   "Geofence area: ${(_initRadius / 100).toStringAsFixed(0)}KM"),
//                               Text("Status: $_userStatus")
//                             ],
//                           ),
//                           Slider(
//                               value: _initRadius,
//                               divisions: 5,
//                               min: 100,
//                               max: 1000,
//                               onChangeEnd: (_) {
//                                 Geofence.removeGeolocation(
//                                   _location!,
//                                   GeolocationEvent.entry,
//                                 ).then((value) {
//                                   _scheduleNotification("Georegion added",
//                                       "Your geofence has been added!");
//                                   // print("Georegion removed");
//                                   _setGeofenceRegion(_geofenceMarkerPosition!);
//                                 });
//                               },
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   _initRadius = newValue;
//                                 });
//                               })
//                         ],
//                       ),
//                     ),
//                   )
//               ],
//             ),
//     );
//   }
// }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';


// class Gmap extends StatefulWidget {
//   @override
//   _GmapState createState() => _GmapState();
// }

// class _GmapState extends State<Gmap> {
//   late GoogleMapController mapController;

//   late LocationData _currentPosition;

//   var lng, lat, loading;
//   bool sitiosToggle = false;

//   var sitios = [];
//   Set<Marker> allMarkers = Set();

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   Set<Circle> circles = Set.from([
//     Circle(
//         circleId: CircleId("myCircle"),
//         radius: 500,
//         center: _createCenter,
//         fillColor: Color.fromRGBO(171, 39, 133, 0.1),
//         strokeColor: Color.fromRGBO(171, 39, 133, 0.5),
//         onTap: () {
//           print('circle pressed');
//         })
//   ]);

//   populateClients() {
//     sitios = [];

//      FirebaseFirestore.instance.collection('location').get().then((docs) {
//       if (docs.documents.isNotEmpty) {
//         setState(() {
//           sitiosToggle = true;
//         });
//         for (int i = 0; i < docs.documents.length; ++i) {
//           initMarker(docs.documents[i].data);
//         }
//       }
//     });
//   }

//   initMarker(afro) {
//     allMarkers.add(Marker(
//       markerId: MarkerId(afro['rname']),
//       draggable: false,
//       infoWindow: InfoWindow(title: afro['rname'], snippet: afro['raddress']),
//       position: LatLng(afro['LatLng'].latitude, afro['LatLng'].longitude),
//     ));
//   }

//   Set<Marker> marker = Set.from([
//     Marker(
//       markerId: MarkerId("mymarker"),
//       alpha: 0.7,
//       draggable: true,
//       infoWindow: const InfoWindow(title: "mymarker", snippet: "mymakrer"),
//     )
//   ]);

//   @override
//   initState() {
//     // ignore: prefer_collection_literals
//     circles = Set.from([
//       Circle(
//           circleId: CircleId("myCircle"),
//           radius: 500,
//           center: _createCenter,
//           fillColor: Color.fromRGBO(171, 39, 133, 0.1),
//           strokeColor: Color.fromRGBO(171, 39, 133, 0.5),
//           onTap: () {
//             print('circle pressed');
//           })
//     loading = true;
//     _getLocation();
//     super.initState();
//   }

//   _getLocation() async {
//     var location = new Location();
//     try {
//       _currentPosition = await location.getLocation();
//       setState(() {
//         lat = _currentPosition.latitude;
//         lng = _currentPosition.longitude;
//         loading = false;
//         print(_currentPosition);
//       }); //rebuild the widget after getting the current location of the user
//     } on Exception {
//       _currentPosition = null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: reddish,
//         primaryTextTheme: TextTheme(
//           title: TextStyle(color: Colors.white),
//         ),
//       ),
//       home: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(100.0),
//           child: new AppBar(
//             centerTitle: true,
//             title: Text(
//               'YOUR NEAREST STORES',
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         body: Stack(
//           children: <Widget>[
//             loading == false
//                 ? GoogleMap(
//                     // circles: circles,
//                     mapType: MapType.normal,
//                     circles: circles,
//                     myLocationButtonEnabled: true,
//                     myLocationEnabled: true,
//                     onMapCreated: _onMapCreated,
//                     zoomGesturesEnabled: true,
//                     compassEnabled: true,
//                     scrollGesturesEnabled: true,
//                     rotateGesturesEnabled: true,
//                     tiltGesturesEnabled: true,
//                     initialCameraPosition: CameraPosition(
//                       target: LatLng(lat, lng),
//                       zoom: 15.0,
//                     ),
//                     markers: allMarkers,
//                   )
//                 : Center(
//                     child: CircularProgressIndicator(),
//                   ),
//             Positioned(
//                 top: MediaQuery.of(context).size.height -
//                     (MediaQuery.of(context).size.height - 70.0),
//                 right: 10.0,
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     populateClients();
//                   },
//                   mini: true,
//                   backgroundColor: Colors.red,
//                   child: Icon(Icons.refresh),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
