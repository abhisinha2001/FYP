import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng currentLocation = LatLng(53.350357, -6.266422);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  Map<String, Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setMarkerIcon();
  }

  void setMarkerIcon() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/marker.png');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: currentLocation,
            zoom: 18,
          ),
          onMapCreated: (controller) {
            mapController = controller;
            addMarker("test", currentLocation);
          },
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }

  addMarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      // icon: markerIcon,
    );
    _markers[id] = marker;
    setState(() {});
  }
}
