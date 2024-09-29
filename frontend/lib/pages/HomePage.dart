import 'package:flutter/material.dart';
import 'package:frontend/models/CCTVModel.dart';
import 'package:frontend/pages/MyPhotoPage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

LatLng currentLocation = LatLng(53.333965, -6.263233);

var URL = "https://22ba-89-101-60-203.ngrok-free.app/allcctvs";

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

  CCTVModel _currentCCTVData = CCTVModel(
      cctvId: 52,
      cctvRoad: "Test",
      lat: 53.350357,
      long: -6.266422,
      email: "",
      phone: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();

    setCCTVs();
  }

  Future setCCTVs() async {
    // var client = http.Client();

    // var uri = Uri.parse(URL);
    // var response = await client.get(uri);

    // if (response.statusCode == 200) {
    //   var json = response.body;
    //   CCTVData.addAll(CCTVModelFromJson(json));
    // }
    // {
    //  "cctv_id": 39,
    //  "cctv_road": "Harcourt St ",
    //  "lat": 53.333965,
    //  "long": -6.263233,
    //  "policy_url": "https:\/\/www.cctvireland.ie\/pub\/pdf\/Garda-Guidlines-on-CCTV-in-Ireland.pdf",
    //  "Phone": "01 6663805",
    //  "Email": null,
    //  "photos": null,
    //  "permissions": {"retention":"28","storage":true,"facial_recognition":true}
    // },
    //

    CCTVData.add(CCTVModel(
        cctvId: 39,
        lat: 53.333965,
        long: -6.263233,
        cctvRoad: "Harcourt St ",
        email: "Not Available",
        phone: "Not Available",
        policyUrl: "https:\/\/www.richmond.gov.uk\/cctv"));

    CCTVData.add(CCTVModel(
        cctvId: 52,
        lat: 53.350357,
        long: -6.266422,
        cctvRoad: "Parnell St ",
        email: "info@odce.ie",
        phone: "Not Available",
        policyUrl: "https:\/\/www.richmond.gov.uk\/cctv"));

    CCTVData.add(CCTVModel(
        cctvId: 203,
        lat: 53.330227,
        long: -6.264374,
        cctvRoad: "Richmond St South ",
        email: "Not Available",
        phone: "Not Available",
        policyUrl: "https:\/\/www.richmond.gov.uk\/cctv"));

    CCTVData.add(CCTVModel(
        cctvId: 204,
        lat: 53.330338,
        long: -6.259884,
        cctvRoad: "Ranelagh Rd ",
        email: "Not Available",
        phone: "Not Available",
        policyUrl: "https:\/\/www.richmond.gov.uk\/cctv"));

    CCTVData.add(CCTVModel(
        cctvId: 218,
        lat: 53.330822,
        long: -6.258903,
        cctvRoad: "Ranelagh Rd ",
        email: "res.charlemont@claytonhotels.com",
        phone: "+353 (0)1 960 6700",
        policyUrl:
            "https:\/\/www.claytonhotelcharlemont.com\/privacy-statement\/"));

    CCTVData.add(CCTVModel(
        cctvId: 237,
        lat: 53.341104,
        long: -6.250811,
        cctvRoad: "Merrion Sq North  \/ Merrion Sq West",
        email: "Not Available",
        phone: "+ 353 1 661 5133",
        policyUrl:
            "https:\/\/www.nationalgallery.ie\/what-we-do\/governance\/privacy-and-data-protection\/privacy-notice"));

    CCTVData.add(CCTVModel(
        cctvId: 276,
        lat: 53.337704,
        long: -6.262714,
        cctvRoad: "Stephen's Green ",
        email: "info@stephensgreen.com",
        phone: "+353 (01) 4780888",
        policyUrl: "https:\/\/stephensgreen.com\/privacy-policy\/"));

    CCTVData.add(CCTVModel(
        cctvId: 282,
        lat: 53.341327,
        long: -6.258309,
        cctvRoad: "Dawson Street",
        email: "dataprotection@ria.ie",
        phone: "00 353 1 6762570",
        policyUrl: "https:\/\/www.richmond.gov.uk\/cctv"));

    CCTVData.add(CCTVModel(
        cctvId: 286,
        lat: 53.344643,
        long: -6.259576,
        cctvRoad: "College Green",
        email: "dataprotection@tcd.ie",
        phone: "Not Available",
        policyUrl:
            "https:\/\/www.tcd.ie\/about\/policies\/cctv-policy.php#systems"));

    CCTVData.add(CCTVModel(
        cctvId: 319,
        lat: 53.34711,
        long: -6.261015,
        cctvRoad: "College Green",
        email: "Not Available",
        phone: "Not Available",
        policyUrl: "https:\/\/www.richmond.gov.uk\/cctv"));
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
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
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        _currentCCTVData.cctvRoad,
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Email:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      _currentCCTVData.email.toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Phone:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      _currentCCTVData.phone.toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        ElevatedButton(
                          onPressed: () {
                            mylaunchURL(_currentCCTVData.policyUrl!);
                          },
                          child: Text(
                            "Press to view Privacy Policy Statement",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addMarker() {
    for (CCTVModel temp in CCTVData) {
      LatLng location = LatLng(temp.lat, temp.long);
      var marker = Marker(
          markerId: MarkerId(temp.cctvId.toString()),
          position: location,
          onTap: () {
            setState(() {
              _infoWindowPosition = 0;
              _currentCCTVData.cctvRoad = temp.cctvRoad;
              _currentCCTVData.cctvId = temp.cctvId;
              _currentCCTVData.lat = temp.lat;
              _currentCCTVData.long = temp.long;
              _currentCCTVData.phone = temp.phone;
              _currentCCTVData.email = temp.email;
              _currentCCTVData.policyUrl = temp.policyUrl;
            });
          }
          // icon: markerIcon,
          );
      _markers[temp.cctvId.toString()] = marker;
    }

    setState(() {});
  }
}
