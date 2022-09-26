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
