import 'package:flutter/material.dart';
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

  // Menentukan tinggi AppBar berdasarkan orientasi
  final double appBarHeight = isPortrait
      ? mediaQuery.size.height * 0.05
      : mediaQuery.size.height * 0.12;

  final double minIconSize = isPortrait ? 30.0 : 24.0;
  final double minFontSize = isPortrait ? 20.0 : 16.0;

  // Menentukan ukuran ikon dan teks berdasarkan appBarHeight
  final double iconSize = (appBarHeight * 0.4).clamp(minIconSize, double.infinity);
  final double fontSize = (appBarHeight * 0.3).clamp(minFontSize, double.infinity);

  return PreferredSize(
    preferredSize: Size.fromHeight(appBarHeight),
    child: ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.02),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Bank Haji',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: fontSize, // Ukuran teks
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        elevation: 4, // Menambahkan bayangan pada AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            // Transparent area in AppBar
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.02),
            child: IconButton(
              icon: Icon(
                Icons.notifications,
                size: iconSize, // Ukuran ikon
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(1.0, 1.0),
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

class HelpFunctions {
  static Widget buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
      ),
    );
  }

  // Fungsi untuk membangun Search Bar
  static Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
        ),
        onChanged: (query) {
          // Handle search query change
        },
      ),
    );
  }

  static Widget buildAdditionalSection() {
    return Column(
      children: [
        buildSettingItem('Kartu Kredit', '', true),
        buildSettingItem('Top Up', '', true),
        buildSettingItem('Linkage E-wallet', '', true),
        buildSettingItem('Promo', '', true),
        buildSettingItem('Instant Acces', '', true),
        buildSettingItem('E-money', '', true),
        buildSettingItem('Bayar', '', true),
        buildSettingItem('Transfer', '', true),
        buildSettingItem('Deposito', '', true),
        buildSettingItem('Pembukaan Tabungan', '', true),
        buildSettingItem('Akun dan Keamana', '', true),
        buildSettingItem('Ivestasi', '', true),
      ],
    );
  }

  static Widget buildSettingItem(String title, String value, bool showArrow) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value.isNotEmpty) Text(
              value, style: TextStyle(color: Colors.grey)),
          if (showArrow) Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
      onTap: () {
        // Handle tap
      },
    );
  }
}

// Fungsi untuk membangun BottomAppBar
Widget buildBottomAppBar(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.topCenter,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
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
                  IconButton(
                    icon: const Icon(Icons.home, size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).push(NoAnimationPageRoute(
                        page: HomePage(),
                      ));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.history, size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).push(NoAnimationPageRoute(
                        page: HistoryPage(),
                      ));
                    },
                  ),
                  SizedBox(width: screenWidth * 0.15), // Space untuk FAB, 15% dari lebar layar
                  IconButton(
                    icon: const Icon(Icons.help_outline, size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).push(NoAnimationPageRoute(
                        page: HelpPage(),
                      ));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_outline, size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).push(NoAnimationPageRoute(
                        page: AccountPage(),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: -20, // Jarak dari bagian atas
        left: (screenWidth - 70) / 2, // Posisi horizontal, agar berada di tengah
        child: SizedBox(
          width: 70, // Lebar FAB
          height: 70, // Tinggi FAB
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ScanQRPage(),
              ));
            },
            backgroundColor: Colors.white,
            elevation: 5,
            shape: CircleBorder(),
            child: const Icon(Icons.qr_code_scanner, color: Colors.lightBlueAccent, size: 40),
          ),
        ),
      ),
    ],
  );
}