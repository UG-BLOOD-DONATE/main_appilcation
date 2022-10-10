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

//   Set<Circle> circles = {
//     Circle(
//         circleId: CircleId("myCircle"),
//         radius: 500,
//         center: _createCenter(),
//         fillColor: Color.fromRGBO(171, 39, 133, 0.1),
//         strokeColor: Color.fromRGBO(171, 39, 133, 0.5),
//         onTap: () {
//           print('circle pressed');
//         })
//   };

//   populateClients() {
//     sitios = [];

//     FirebaseFirestore.instance.collection('retailers').get().then((docs) {
//       DocumentSnapshot documents=DocumentSnapshot();
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
//       infoWindow: InfoWindow(title: "mymarker", snippet: "mymakrer"),
//     )
//   ]);

//   @override
//   initState() {
//     // ignore: prefer_collection_literals
//     circles = Set.from([
//       Circle(
//           circleId: CircleId("myCircle"),
//           radius: 500,
//           center: _createCenter(),
//           fillColor: Color.fromRGBO(171, 39, 133, 0.1),
//           strokeColor: Color.fromRGBO(171, 39, 133, 0.5),
//           onTap: () {
//             print('circle pressed');
//           })
//     ]);

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
//       //_currentPosition = null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Colors.red,
//         primaryTextTheme: TextTheme(
//          // title: TextStyle(color: Colors.white),
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

//   LatLng _createCenter() {
//     return _createLatLng(lat , lng);
//   }

//   LatLng _createLatLng(double lat, double lng) {
//     return LatLng(lat, lng);
//   }
// }