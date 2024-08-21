import 'package:flutter/material.dart';
import 'components/body.dart';

class LocationTrackingScreen extends StatelessWidget {
  const LocationTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location App'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Body(),
      ),
    );
  }
}
