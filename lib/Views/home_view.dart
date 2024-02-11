import 'package:flutter/material.dart';
import 'package:pro_google_map/Views/Widgets/custom_camers_postion.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: CustomCameraPostionWidget()),
    );
  }
}
