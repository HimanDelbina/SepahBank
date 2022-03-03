import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sepah/Models/my_market.dart';
import 'package:sepah/Static/url.dart';
import 'package:sepah/Static/user.dart';

class GoogleMapMarker extends StatefulWidget {
  const GoogleMapMarker({Key? key}) : super(key: key);

  @override
  _GoogleMapMarkerState createState() => _GoogleMapMarkerState();
}

class _GoogleMapMarkerState extends State<GoogleMapMarker> {
  LatLng initPosition = const LatLng(0, 0);
  LatLng currentLatLng = const LatLng(0.0, 0.0);
  LocationPermission permission = LocationPermission.denied;
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    getMarker();

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
    return Scaffold(
      body: Stack(
        children: [
          lengthMarker != 0
              ? googleMap = GoogleMap(
                  markers: markers!.toSet(),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  mapType: MapType.terrain,
                  initialCameraPosition:
                      CameraPosition(zoom: 14.0, target: currentLatLng),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                )
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  GoogleMap? googleMap;
  // Completer<GoogleMapController> _controller = Completer();
  Set<Marker>? markers;
  int filterMarkerIndex = 0;
  List? marker = [];
  Set<Marker> mymarker = Set<Marker>();
  var filterMarker;
  var listMarker;
  int lengthMarker = 0;
  String markerTitle = '';
  String markerDescription = '';

  String url = UrlStaticFile.url + "marker/get_all_marker";
  Future<List<MyMarketModel>> getMarker() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        listMarker = res.map((e) => MyMarketModel.fromJson(e)).toList();
        setState(() {
          marker = listMarker;
        });
        lengthMarker = marker!.length;
        markers = Set<Marker>();
        marker!.forEach((marker) async {
          var x = (marker).image;
          print((marker).user.id);
          print("------------");
          print(UserStaticFile.user_id);
          String imageUrl = '';
          if ((marker).user.id == UserStaticFile.user_id) {
            if ((marker).selectMode == "1") {
              imageUrl = "http://smartrebin.ir:2404/image/user/bazarRed.png";
            } else if ((marker).selectMode == "2") {
              imageUrl = "http://smartrebin.ir:2404/image/user/moshtariRed.png";
            } else if ((marker).selectMode == "3") {
              imageUrl = "http://smartrebin.ir:2404/image/user/shobeRed.png";
            } else if ((marker).selectMode == "4") {
              imageUrl = "http://smartrebin.ir:2404/image/user/taghirRed.png";
            }
          } else if ((marker).user.id != UserStaticFile.user_id) {
            imageUrl = "http://smartrebin.ir:2404" + x!;
          }
          final response = await http.get(Uri.parse(imageUrl));
          markers!.add(Marker(
              markerId: MarkerId(
                (marker).id.toString(),
              ),
              icon: BitmapDescriptor.fromBytes(response.bodyBytes),
              position: LatLng((marker).lut, (marker).long),
              infoWindow: InfoWindow(
                title: (marker).name,
                snippet: (marker).description,
              )));

          setState(() {});
        });
        return listMarker;
      } else {
        var res = response.body;
        listMarker = myMarketModelFromJson(res);

        lengthMarker = marker!.length;
        markers = Set<Marker>();
        print(lengthMarker);
        marker!.forEach((m) async {
          var x = (m).image;
          final response = await http.get(Uri.parse(x!));
          print('x');
          markers!.add(Marker(
              markerId: MarkerId(
                (m).id.toString(),
              ),
              icon: BitmapDescriptor.fromBytes(response.bodyBytes),
              position: LatLng((m).lut!, (m).long!),
              infoWindow: InfoWindow(
                title: (m).name!,
                snippet: (m).description!,
              )));
          setState(() {});
        });
        return listMarker!;
      }
    } catch (e) {
      return listMarker!;
    }
  }
}
