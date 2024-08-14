import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

/// Widget utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Meminta izin yang diperlukan
    _requestPermissions();

    return MaterialApp(
      title: 'Mobile Banking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }

  /// Metode untuk meminta izin yang diperlukan oleh aplikasi
  Future<void> _requestPermissions() async {
    // Meminta izin untuk akses lokasi
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }

    // Meminta izin untuk akses penyimpanan
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }

    // Meminta izin untuk akses kamera
    if (await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
  }
}
