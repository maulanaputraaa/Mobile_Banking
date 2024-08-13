import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Meminta izin saat aplikasi dimulai
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

  // Metode untuk meminta izin
  Future<void> _requestPermissions() async {
    // Minta izin untuk lokasi
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
    // Minta izin untuk penyimpanan
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
  }
}
