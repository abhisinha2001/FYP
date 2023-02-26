import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng currentLocation = LatLng(53.350357, -6.266422);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;

  Map<String, Marker> _markers = {};
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
    );
    _markers[id] = marker;
    setState(() {});
  }
}
