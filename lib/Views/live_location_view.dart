import 'package:flutter/material.dart';
import 'package:pro_google_map/Views/Widgets/live_location_body_widget.dart';

class LiveLocationView extends StatelessWidget {
  const LiveLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: LiveLocationBodyWidget());
  }
}
