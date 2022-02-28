import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sepah/Page/Marketing/add_market.dart';

class GoogleMapSelect extends StatefulWidget {
  const GoogleMapSelect({Key? key}) : super(key: key);

  @override
  _GoogleMapSelectState createState() => _GoogleMapSelectState();
}

class _GoogleMapSelectState extends State<GoogleMapSelect> {
  LatLng initPosition = const LatLng(0, 0);
  LatLng currentLatLng = const LatLng(0.0, 0.0);
  LocationPermission permission = LocationPermission.denied;
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();

    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    getCurrentLocation();
    checkPermission();
  }

  //checkPersion before initialize the map
  void checkPermission() async {
    permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
  }

  // get current location
  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition().then((currLocation) {
      setState(() {
        currentLatLng = LatLng(currLocation.latitude, currLocation.longitude);
      });
      myLocLat = currentLatLng.latitude;
      myLocLong = currentLatLng.longitude;
    });
  }

  //call this onPress floating action button
  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    getCurrentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: currentLatLng,
        zoom: 18.0,
      ),
    ));
  }

  //Check permission status and currentPosition before render the map
  bool checkReady(LatLng? x, LocationPermission? y) {
    if (x == initPosition ||
        y == LocationPermission.denied ||
        y == LocationPermission.deniedForever) {
      return true;
    } else {
      return false;
    }
  }

  double? myLocLat;
  double? myLocLong;
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          checkReady(currentLatLng, permission)
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition:
                      CameraPosition(zoom: 14.0, target: currentLatLng),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set<Marker>.of(<Marker>[
                    Marker(
                      draggable: true,
                      onDragEnd: (value) {
                        setState(() {
                          myLocLat = value.latitude;
                          myLocLong = value.longitude;
                        });
                        print(value);
                      },
                      markerId: MarkerId("assets/Rahvar.png"),
                      position: currentLatLng,
                      icon: BitmapDescriptor.defaultMarker,
                    ),
                  ]),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: FloatingActionButton(
                        backgroundColor: Colors.orangeAccent,
                        onPressed: _currentLocation,
                        child: const Icon(Icons.location_on)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddMarket(
                                lat: myLocLat,
                                long: myLocLong,
                              ),
                            ));
                      },
                      child: Container(
                        height: myHeight * 0.07,
                        width: myWidth * 0.25,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: const Center(
                          child: Text(
                            "تایید",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
