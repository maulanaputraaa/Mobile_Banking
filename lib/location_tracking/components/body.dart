import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as l;
import 'package:permission_handler/permission_handler.dart';
import 'location_tracking_menu.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool gpsEnabled = false;
  bool permissionGranted = false;
  l.Location location = l.Location();
  Timer? trackingTimer;
  bool trackingEnabled = false;
  l.LocationData? initialLocation;
  l.LocationData? latestLocation;
  String? initialStreetName;
  String? latestStreetName;
  double? distanceBetween;
  List<LatLng> routePoints = [];

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  @override
  void dispose() {
    stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LocationTrackingMenu(
          gpsEnabled: gpsEnabled,
          permissionGranted: permissionGranted,
          trackingEnabled: trackingEnabled,
          onGpsEnablePressed: requestEnableGps,
          onRequestPermissionPressed: requestLocationPermission,
          onStartTrackingPressed: startTracking,
          onStopTrackingPressed: stopTracking,
        ),
        Expanded(child: buildLocationList()),
      ],
    );
  }

  Widget buildLocationList() {
    return ListView(
      children: [
        if (initialLocation != null) buildLocationTile(initialLocation!, initialStreetName ?? "Loading..."),
        if (latestLocation != null) buildLocationTileWithDistance(latestLocation!, latestStreetName ?? "Loading..."),
        if (routePoints.isNotEmpty) buildRouteMap(),
      ],
    );
  }

  Widget buildLocationTile(l.LocationData location, String streetName) {
    return Column(
      children: [
        ListTile(
          title: Text("${location.latitude}, ${location.longitude}"),
          subtitle: Text(streetName),
        ),
        SizedBox(
          height: 200,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0),
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0),
                    child: const Icon(Icons.location_on, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLocationTileWithDistance(l.LocationData location, String streetName) {
    return Column(
      children: [
        ListTile(
          title: Text("${location.latitude}, ${location.longitude}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(streetName),
              if (distanceBetween != null)
                Text("Jarak ke lokasi tujuan: ${distanceBetween!.toStringAsFixed(2)} meter"),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRouteMap() {
    return SizedBox(
      height: 200,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(initialLocation?.latitude ?? 0.0, initialLocation?.longitude ?? 0.0),
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: routePoints,
                strokeWidth: 4.0,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> getStreetName(double latitude, double longitude, {bool isInitial = false}) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          if (isInitial) {
            initialStreetName = placemarks[0].street ?? "Unknown Street";
          } else {
            latestStreetName = placemarks[0].street ?? "Unknown Street";
          }
        });
      }
    } catch (e) {
      log("Failed to get street name: $e");
      setState(() {
        if (isInitial) {
          initialStreetName = "Error fetching street name";
        } else {
          latestStreetName = "Error fetching street name";
        }
      });
    }
  }

  void requestEnableGps() async {
    if (gpsEnabled) {
      log("GPS sudah aktif");
    } else {
      bool isGpsActive = await location.requestService();
      if (!isGpsActive) {
        setState(() {
          gpsEnabled = false;
        });
        log("User tidak mengaktifkan GPS");
      } else {
        log("GPS diaktifkan");
        setState(() {
          gpsEnabled = true;
        });
      }
    }
  }

  void requestLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.locationWhenInUse.request();
    if (permissionStatus == PermissionStatus.granted) {
      setState(() {
        permissionGranted = true;
      });
    } else {
      setState(() {
        permissionGranted = false;
      });
    }
  }

  Future<bool> isPermissionGranted() async {
    return await Permission.locationWhenInUse.isGranted;
  }

  Future<bool> isGpsEnabled() async {
    return await Permission.location.serviceStatus.isEnabled;
  }

  checkStatus() async {
    bool _permissionGranted = await isPermissionGranted();
    bool _gpsEnabled = await isGpsEnabled();
    setState(() {
      permissionGranted = _permissionGranted;
      gpsEnabled = _gpsEnabled;
    });
  }

  void addLocation(l.LocationData data, {bool isInitial = false}) async {
    if (isInitial) {
      setState(() {
        initialLocation = data;
      });
      await getStreetName(data.latitude!, data.longitude!, isInitial: true);
    } else {
      setState(() {
        latestLocation = data;
      });
      await getStreetName(data.latitude!, data.longitude!);
      calculateDistanceAndRoute();
    }
  }

  void calculateDistanceAndRoute() {
    if (initialLocation != null && latestLocation != null) {
      // Hitung jarak
      final distance = const Distance();
      distanceBetween = distance(
        LatLng(initialLocation!.latitude!, initialLocation!.longitude!),
        LatLng(latestLocation!.latitude!, latestLocation!.longitude!),
      );

      // Buat rute antara lokasi tetap dan lokasi terbaru
      routePoints = [
        LatLng(initialLocation!.latitude!, initialLocation!.longitude!),
        LatLng(latestLocation!.latitude!, latestLocation!.longitude!),
      ];

      setState(() {});
    }
  }

  void startTracking() async {
    if (!(await isGpsEnabled())) {
      return;
    }
    if (!(await isPermissionGranted())) {
      return;
    }

    // Ambil lokasi pertama langsung saat tracking dimulai
    l.LocationData initialLocationData = await location.getLocation();
    addLocation(initialLocationData, isInitial: true);

    // Timer untuk menjalankan tracking
    trackingTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      l.LocationData locationData = await location.getLocation();
      addLocation(locationData);
    });

    setState(() {
      trackingEnabled = true;
    });
  }

  void stopTracking() {
    trackingTimer?.cancel();

    setState(() {
      trackingEnabled = false;
      initialLocation = null;
      latestLocation = null;
      distanceBetween = null;
      routePoints.clear();
    });
  }

}
