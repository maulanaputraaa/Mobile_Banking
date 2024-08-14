import 'package:flutter/material.dart';
import 'dart:async';
import '../main_feature_function/qrcode_page.dart';
import '../main_page/account_page.dart';
import '../main_page/help_page.dart';
import '../main_page/history_page.dart';
import '../main_page/home_page.dart';
import '../screen/animate_page.dart';

// Fungsi untuk membangun AppBar
PreferredSizeWidget buildAppBar(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final bool isPortrait = mediaQuery.orientation == Orientation.portrait;

  final double appBarHeight = isPortrait
      ? mediaQuery.size.height * 0.05
      : mediaQuery.size.height * 0.12;

  final double minIconSize = isPortrait ? 30.0 : 24.0;
  final double minFontSize = isPortrait ? 20.0 : 16.0;

  final double iconSize = (appBarHeight * 0.4).clamp(minIconSize, double.infinity);
  final double fontSize = (appBarHeight * 0.3).clamp(minFontSize, double.infinity);

  return PreferredSize(
    preferredSize: Size.fromHeight(appBarHeight),
    child: ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.02),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Listrik',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: fontSize,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        elevation: 4,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.02),
            child: IconButton(
              icon: Icon(
                Icons.notifications,
                size: iconSize,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
              onPressed: () {
                // Handle notifications button press
              },
            ),
          ),
        ],
      ),
    ),
  );
}

// Fungsi untuk menampilkan dua container
Widget buildListrikOptions() {
  return Column(
    children: [
      const SizedBox(height: 20),
      // Container pertama
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tagihan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Image.asset(
                'assets/icon/listrik_icon.png', // Path gambar dalam folder assets
                width: 30, // Lebar gambar
                height: 30, // Tinggi gambar
              ),
              title: const Text('Tagihan Bulanan'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Handle tap
              },
            ),

          ],
        ),
      ),
      const SizedBox(height: 20),
      // Container kedua
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: const Text('Top Up Token Listrik'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Handle tap
              },
            ),
          ],
        ),
      ),
    ],
  );
}

// Widget Untuk BottomAppBar
Widget buildBottomAppBar(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.topCenter,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
          child: Container(
            height: 60.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade700, Colors.blue.shade500],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: BottomAppBar(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Tombol Home
                  buildIconWithLabel(
                    context,
                    icon: Icons.home,
                    label: 'Home',
                    onTap: () {
                      Navigator.of(context).push(NoAnimationPageRoute(
                        page: HomePage(),
                      ));
                    },
                  ),
                  // Tombol Riwayat
                  buildIconWithLabel(
                    context,
                    icon: Icons.history,
                    label: 'Riwayat',
                    onTap: () {
                      Navigator.of(context).push(NoAnimationPageRoute(
                        page: HistoryPage(),
                      ));
                    },
                  ),
                  SizedBox(width: screenWidth * 0.15),
                  // Tombol Bantuan
                  buildIconWithLabel(
                    context,
                    icon: Icons.help_outline,
                    label: 'Bantuan',
                    onTap: () {
                      Navigator.of(context).push(NoAnimationPageRoute(
                        page: const HelpPage(),
                      ));
                    },
                  ),
                  // Tombol User
                  buildIconWithLabel(
                    context,
                    icon: Icons.person_outline,
                    label: 'Akun',
                    onTap: () {
                      Navigator.of(context).push(NoAnimationPageRoute(
                        page: const AccountPage(),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // Tombol Untuk Floating Button QR Code
      Positioned(
        top: -20,
        left: (screenWidth - 70) / 2,
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScanQRPage(),
              ));
            },
            backgroundColor: Colors.white,
            elevation: 5,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.qr_code_scanner,
              color: Colors.lightBlueAccent,
              size: 40,
            ),
          ),
        ),
      ),
    ],
  );
}

// Fungsi untuk membuat Icon dengan Label di bawahnya
Widget buildIconWithLabel(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 22, color: Colors.white),
        const SizedBox(height: 0),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
      ],
    ),
  );
}