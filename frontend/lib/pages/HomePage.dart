import 'package:flutter/material.dart';
import 'package:frontend/models/CCTVModel.dart';
import 'package:frontend/pages/MyPhotoPage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

  bool _isLoading = true;

  double _infoWindowPosition = -300;

  CCTVModel _currentCCTVData =
      CCTVModel(52, 53.350357, -6.266422, cctv_road: "Test");

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
        _isLoading = false;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  mylaunchURL(String s) async {
    if (await canLaunchUrlString(s)) {
      await launchUrlString(s);
    } else {
      throw 'Could not launch $s';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
              onPressed: () {
                print("Button was pressed");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyPhotoPage()));
              },
              child: Icon(Icons.add_a_photo)),
        ),
        body: Stack(
          children: [
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      // target: LatLng(_currentPosition?.latitude ?? 53.333965,
                      //     _currentPosition?.longitude ?? -6.263233),
                      target: LatLng(53.350357, -6.266422),
                      zoom: 18,
                    ),
                    onMapCreated: (controller) {
                      mapController = controller;
                      addMarker();
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: _markers.values.toSet(),
                  ),
            AnimatedPositioned(
              bottom: _infoWindowPosition,
              right: 0,
              left: 0,
              duration: Duration(milliseconds: 250),
              child: Align(
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 20,
                          offset: Offset.zero,
                          color: Colors.grey.withOpacity(0.5),
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_currentCCTVData.cctv_road),
                      Text(_currentCCTVData.cctv_id.toString()),
                      Text(_currentCCTVData.lat.toString()),
                      Text(_currentCCTVData.long.toString()),
                      ElevatedButton(
                          onPressed: () {
                            mylaunchURL("https:\/\/www.richmond.gov.uk\/cctv");
                          },
                          child:
                              Text("Press to view Privacy Policy Statement")),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addMarker() {
    for (CCTVModel temp in CCTVData) {
      LatLng location = LatLng(temp.lat, temp.long);
      var marker = Marker(
          markerId: MarkerId(temp.cctv_id.toString()),
          position: location,
          onTap: () {
            setState(() {
              _infoWindowPosition = 0;
              _currentCCTVData.cctv_road = temp.cctv_road;
              _currentCCTVData.cctv_id = temp.cctv_id;
              _currentCCTVData.lat = temp.lat;
              _currentCCTVData.long = temp.long;
            });
          }
          // icon: markerIcon,
          );
      _markers[temp.cctv_id.toString()] = marker;
    }

    setState(() {});
  }
}
