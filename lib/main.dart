import 'package:flutter/material.dart';
import 'package:pro_google_map/Views/home_view.dart';

void main() {
  runApp(const FlutterGoogleMaps());
}

class FlutterGoogleMaps extends StatelessWidget {
  const FlutterGoogleMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
