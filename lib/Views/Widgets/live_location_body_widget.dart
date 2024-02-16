import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LiveLocationBodyWidget extends StatefulWidget {
  const LiveLocationBodyWidget({super.key});

  @override
  State<LiveLocationBodyWidget> createState() => _LiveLocationBodyWidgetState();
}

class _LiveLocationBodyWidgetState extends State<LiveLocationBodyWidget> {
  late CameraPosition initialCameraPostion;
  GoogleMapController? googleMapController;
  late Location location;
  Set<Marker> myMarker = {};
  num latitude = 0;
  num longitude = 0;
  @override
  void initState() {
    super.initState();
    initCameraPostion();
    // initMyMarker();
    location = Location();
    updateMyLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: initialCameraPostion,
        zoomControlsEnabled: false,
        markers: myMarker,
        onMapCreated: (controller) {
          googleMapController = controller;
          initStyleGoogleMap();
        },
      ),
    );
  }

  void initCameraPostion() {
    initialCameraPostion = const CameraPosition(
      target: LatLng(30.52802347051582, 31.0457970214283),
      zoom: 16,
    );
  }

  void initStyleGoogleMap() async {
    var mapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/retro_map_style.json');
    googleMapController!.setMapStyle(mapStyle);
  }

  // void initMyMarker() {
  //   var myMark = const Marker(
  //     markerId: MarkerId('0'),
  //     position: LatLng(30.52802347051582, 31.0457970214283),
  //     infoWindow: InfoWindow(
  //       title: 'My Home Postion',
  //       snippet: 'Amr ',
  //     ),
  //   );
  //   myMarker.add(myMark);
  // }

  Future<void> checkAndRequestLocationService() async {
    var isServiceEnabaled = await location.serviceEnabled();
    if (!isServiceEnabaled) {
      isServiceEnabaled = await location.requestService();
      if (!isServiceEnabaled) {
        Fluttertoast.showToast(
          msg: 'Please Open Location Service !',
          backgroundColor: Colors.black,
          fontSize: 14,
          textColor: Colors.white,
          timeInSecForIosWeb: 2,
          webPosition: 'center',
        );
      }
    }
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        Fluttertoast.showToast(
          msg: 'Please Allow Location For diplay Live Location !',
          backgroundColor: Colors.black,
          fontSize: 14,
          textColor: Colors.white,
          timeInSecForIosWeb: 2,
          webPosition: 'center',
        );
      }
      return false;
    }
    return true;
  }

  void getLocationData() async {
    await location.changeSettings(
      distanceFilter: 2,
    );
    location.onLocationChanged.listen((locationData) {
      var latLong = LatLng(locationData.latitude!, locationData.longitude!);
      googleMapController?.animateCamera(
        CameraUpdate.newLatLng(
          latLong,
        ),
      );
      var myMark = Marker(
        markerId: const MarkerId('0'),
        position: latLong,
        infoWindow: const InfoWindow(
          title: 'My Home Postion',
          snippet: 'Amr ',
        ),
      );
      myMarker.add(myMark);
      setState(() {});
    });
  }

  void updateMyLocation() async {
    await checkAndRequestLocationService();
    var hasPermission = await checkAndRequestLocationPermission();
    if (hasPermission) {
      getLocationData();
    } else {
      Fluttertoast.showToast(
        msg: 'Please Turn on Location Service ',
      );
    }
  }
}
