import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pro_google_map/models/plases_model.dart';

class CustomCameraPostionWidget extends StatefulWidget {
  const CustomCameraPostionWidget({super.key});

  @override
  State<CustomCameraPostionWidget> createState() =>
      _CustomCameraPostionWidgetState();
}

class _CustomCameraPostionWidgetState extends State<CustomCameraPostionWidget> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  double zoomMap = 16;
  Set<Marker> markers = {};
  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      target: const LatLng(30.527641675593546, 31.046770663274646),
      zoom: zoomMap,
    );
    initMarkers();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GoogleMap(
            markers: markers,
            initialCameraPosition: initialCameraPosition,
            // cameraTargetBounds: CameraTargetBounds(
            //   LatLngBounds(
            //     southwest: const LatLng(30.53971309079529, 31.01126501100858),
            //     northeast: const LatLng(30.587164618597974, 31.00895873550158),
            //   ),
            // ),
            onMapCreated: (controller) {
              googleMapController = controller;
              initMapStyle();
            },
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 60,
            child: ElevatedButton(
              onPressed: () {
                googleMapController.animateCamera(
                  CameraUpdate.newLatLng(
                    const LatLng(30.420970399108224, 31.036469471164143),
                  ),
                );
                setState(() {});
              },
              child: const Text('Change Postion'),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 40,
            left: 0,
            child: Slider(
              value: zoomMap,
              min: 0,
              max: 20,
              onChanged: (value) {
                zoomMap = value;
                googleMapController.animateCamera(
                  CameraUpdate.zoomTo(zoomMap),
                );
                setState(() {});
              },
              label: '$zoomMap',
              divisions: 10,
            ),
          ),
        ],
      ),
    );
  }

  void initMapStyle() async {
    var retroMApStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/retro_map_style.json');
    googleMapController.setMapStyle(retroMApStyle);
  }

  void initMarkers() async {
    var customIconMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(100, 50)),
        'assets/images/download.png');
    var myMArkers = places
        .map(
          (placesModel) => Marker(
            icon: customIconMarker,
            infoWindow: InfoWindow(
              title: placesModel.name,
              snippet: ' this',
            ),
            position: placesModel.latLng,
            markerId: MarkerId(
              placesModel.id.toString(),
            ),
          ),
        )
        .toSet();
    markers.addAll(myMArkers);
    setState(() {});
    // var getMarker = const Marker(
    //   markerId: MarkerId('0'),
    //   position: LatLng(30.52802347051582, 31.0457970214283),
    // );
    // markers.add(getMarker);
  }
}
