import 'package:flutter/material.dart';

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
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.02),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: iconSize, // Ukuran ikon
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
              SizedBox(width: mediaQuery.size.width * 0.02),
              Text(
                'Mobile Transfer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: fontSize, // Ukuran teks
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        elevation: 4, // Menambahkan bayangan pada AppBar
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            // Transparent area in AppBar
          ),
        ),
      ),
    ),
  );
}

// Fungsi untuk menampilkan dua container
Widget buildTransferOptions() {
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
              'Tambahkan Nomor Rekening',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text('Nomor Rekening Sesama Bank'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Nomor Rekening Semua Bank'),
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
              'Transfer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: const Text('Transfer Sesama Bank'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.swap_horizontal_circle),
              title: const Text('Transfer Semua Bank'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Handle tap
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.hourglass_bottom),
              title: const Text('Status'),
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
