// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DonerProfilePage extends StatefulWidget {
  const DonerProfilePage({super.key});

  @override
  State<DonerProfilePage> createState() => _DonerProfilePageState();
}

class _DonerProfilePageState extends State<DonerProfilePage> {
  MapType _currentMapType = MapType.normal;
  late GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(0.3272399, 32.57796);
  static const LatLng destination = LatLng(0.312222, 32.585556);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void initState() {
    getcurrentLocation();
    // TODO: implement initState
    super.initState();
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
              zoom: 15.5,
              target: LatLng(newlock.latitude!, newlock.longitude!))));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.navigate_before_sharp,
            color: Colors.black,
            size: 24.0,
          ),
          title: const Text("Find Donors"),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: new ListView(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Card(
                      child: Image.asset(
                        'lib/images/ntanda.jpg',
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '                Yiga Gilbert',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ],
                ),
                /*3*/
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.pink),
                  const Text("Wakiso, Uganda")
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: <Widget>[
                    Center(
                      child: new Image.asset(
                        'assets/images/iconsase.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                        child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        // ignore: prefer_const_constructors
                        Text(
                          "6",
                          style: new TextStyle(
                            color: Colors.pink,
                            fontSize: 20,
                          ),
                        ),
                        const Text(
                          " Times donated",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        )
                      ],
                    )),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: <Widget>[
                    new Positioned(
                        child: new Image.asset(
                      'assets/images/icon.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.fitWidth,
                    )),
                    Positioned(
                        child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        // ignore: prefer_const_constructors
                        Text(
                          "Blood Type",
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const Text(
                          " AB+",
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 20,
                          ),
                        )
                      ],
                    )),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  /*1*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.contact_phone,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              label: const Text('Call Now'),
                              onPressed: () {
                                print('Pressed');
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(150, 27, 158, 163)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ))),
                    ],
                  ),
                ),
                Expanded(
                  /*1*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.navigate_before_sharp,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              label: const Text('Request'),
                              onPressed: () {
                                print('Pressed');
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromARGB(255, 233, 10, 103)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ))),
                    ],
                  ),
                ),
              ],
            ),
            new Container(
              height: 350,
              width: 200,
              padding: EdgeInsets.all(10.0),
              child: currentLocation == null
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
                  : Stack(
                      children: <Widget>[
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
                              position: LatLng(currentLocation!.latitude!,
                                  currentLocation!.longitude!),
                            ),
                          },
                        ),
                      ],
                    ),
            ),
          ]),
        ));
  }
}
