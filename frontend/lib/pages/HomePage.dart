import 'package:flutter/material.dart';
import 'package:frontend/models/CCTVModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng currentLocation = LatLng(53.333965, -6.263233);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;

  Map<String, Marker> _markers = {};

  List<CCTVModel> CCTVData = [];

  Position? _currentPosition;

  bool _isLoading = true;

  double infoWindowPosition = -200;

  CCTVModel _currentCCTVData = CCTVModel(52, 53.350357, -6.266422);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();

    setCCTVs();
  }

  void setCCTVs() {
    CCTVData.add(CCTVModel(39, 53.333965, -6.263233, cctv_road: "Parnell St "));
    CCTVData.add(CCTVModel(52, 53.350357, -6.266422, cctv_road: "Parnell St "));
    CCTVData.add(
        CCTVModel(319, 53.34711, -6.261015, cctv_road: "Batchlors Walk "));
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_currentPosition?.latitude ?? 53.333965,
                          _currentPosition?.longitude ?? -6.263233),
                      zoom: 18,
                    ),
                    onMapCreated: (controller) {
                      mapController = controller;
                      addMarker();
                    },
                    markers: _markers.values.toSet(),
                  ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addMarker({lat, long}) {
    for (CCTVModel temp in CCTVData) {
      LatLng location = LatLng(temp.lat, temp.long);
      var marker = Marker(
          markerId: MarkerId(temp.cctv_id.toString()),
          position: location,
          onTap: () {}
          // icon: markerIcon,
          );
      _markers[temp.cctv_id.toString()] = marker;
    }

    setState(() {});
  }
}
