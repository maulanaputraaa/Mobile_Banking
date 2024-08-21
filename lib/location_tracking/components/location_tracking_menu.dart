import 'package:flutter/material.dart';

class LocationTrackingMenu extends StatelessWidget {
  final bool gpsEnabled;
  final bool permissionGranted;
  final bool trackingEnabled;
  final VoidCallback onGpsEnablePressed;
  final VoidCallback onRequestPermissionPressed;
  final VoidCallback onStartTrackingPressed;
  final VoidCallback onStopTrackingPressed;

  const LocationTrackingMenu({
    super.key,
    required this.gpsEnabled,
    required this.permissionGranted,
    required this.trackingEnabled,
    required this.onGpsEnablePressed,
    required this.onRequestPermissionPressed,
    required this.onStartTrackingPressed,
    required this.onStopTrackingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildListTile(
          "GPS",
          gpsEnabled
              ? const Text("Okey")
              : ElevatedButton(
              onPressed: onGpsEnablePressed,
              child: const Text("Enable Gps")),
        ),
        buildListTile(
          "Permission",
          permissionGranted
              ? const Text("Okey")
              : ElevatedButton(
              onPressed: onRequestPermissionPressed,
              child: const Text("Request Permission")),
        ),
        buildListTile(
          "Location",
          trackingEnabled
              ? ElevatedButton(
              onPressed: onStopTrackingPressed,
              child: const Text("Stop"))
              : ElevatedButton(
              onPressed: gpsEnabled && permissionGranted
                  ? onStartTrackingPressed
                  : null,
              child: const Text("Start")),
        ),
      ],
    );
  }

  ListTile buildListTile(String title, Widget? trailing) {
    return ListTile(
      dense: true,
      title: Text(title),
      trailing: trailing,
    );
  }
}
