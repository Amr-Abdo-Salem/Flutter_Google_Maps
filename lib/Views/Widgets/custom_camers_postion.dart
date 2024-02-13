import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pro_google_map/Views/live_location_view.dart';
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
  Set<Polyline> polyLines = {};
  Set<Polygon> polygons = {};
  Set<Circle> circle = {};
  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(
      target: const LatLng(30.527641675593546, 31.046770663274646),
      zoom: zoomMap,
    );
    initMarkers();
    initPloyLines();
    initPloygons();
    initCircle();
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
            polylines: polyLines,
            polygons: polygons,
            markers: markers,
            circles: circle,
            zoomControlsEnabled: false,
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
            right: 10,
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
            right: 10,
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
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: IconButton(
                splashColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LiveLocationView(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.location_pin,
                  size: 40,
                ),
              ),
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
      const ImageConfiguration(),
      'assets/images/download.png',
    );
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

  void initPloyLines() {
    Polyline polyline = const Polyline(
        zIndex: 1,
        polylineId: PolylineId('1'),
        color: Colors.black,
        endCap: Cap.roundCap,
        startCap: Cap.roundCap,
        width: 4,
        points: [
          LatLng(30.53221257423452, 31.045874438889175),
          LatLng(30.52802996034546, 31.049993991437365),
          LatLng(30.52599136037322, 31.043634708793718),
          LatLng(30.52130729673009, 31.053438468190322),
        ]);
    Polyline polyline1 = const Polyline(
      zIndex: 2,
      polylineId: PolylineId('2'),
      color: Colors.grey,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      width: 4,
      points: [
        LatLng(30.52649437203817, 31.05640104008638),
        LatLng(30.527010631402106, 31.03049379246221),
      ],
      patterns: [PatternItem.dot],
    );
    polyLines.add(polyline);
    polyLines.add(polyline1);
  }

  void initPloygons() {
    Polygon polygon = Polygon(
      fillColor: Colors.black.withOpacity(0.2),
      points: const [
        LatLng(30.595298507260548, 31.009502630197893),
        LatLng(30.564051938664328, 31.04163199825233),
        LatLng(30.532966132162947, 31.008709312468152),
        LatLng(30.5645642586702, 30.984314792278674),
        LatLng(30.584371890599467, 30.995024581630155),
      ],
      polygonId: const PolygonId('1'),
      holes: const [
        [
          LatLng(30.567733037160764, 31.009297196801757),
          LatLng(30.553664558326595, 31.01848292247298),
          LatLng(30.55846497669368, 30.997797509637078),
        ]
      ],
    );
    polygons.add(polygon);
  }

  void initCircle() {
    Circle circles = Circle(
      fillColor: Colors.black.withOpacity(0.5),
      circleId: const CircleId('1'),
      radius: 500,
      center: const LatLng(30.52358931172052, 31.04735431564734),
    );
    circle.add(circles);
  }

  // Future<Uint8List> getImageFromRawData(String imageUrl, double widht) async {
  //   var imageData = await rootBundle.load(imageUrl);
  //   var imageCodec = await ui.instantiateImageCodec(
  //     imageData.buffer.asUint8List(),
  //     targetWidth: widht.round(),
  //   );
  //   var imageFramInfo = await imageCodec.getNextFrame();
  //   var imageByData =
  //       await imageFramInfo.image.toByteData(format: ui.ImageByteFormat.png);
  //   return imageByData!.buffer.asUint8List();
  // }
}
