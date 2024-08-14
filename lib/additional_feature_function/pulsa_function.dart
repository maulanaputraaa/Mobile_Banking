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
              'Pulsa',
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

//Fungsi Untuk Memasukkan Nomor HP dan Nomor HP yang Tersimpan
Widget buildNomorHP(TextEditingController controller, Function(String) onChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Nomor HP',
          hintText: 'Masukkan nomor HP',
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/icon/handpone_icon.png',
              width: 24,
              height: 24,
            ),
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        onChanged: onChanged,
      ),
      const SizedBox(height: 10),
      GestureDetector(
        onTap: () {
          controller.text = '08980626720'; // Ganti dengan nomor HP yang sesuai
          onChanged('08980626720');
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            '08980626720', // Ganti dengan nomor HP yang sesuai
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}

// Fungsi Untuk Pilihan Pulsa atau Paket Data
Widget buildPilihNominal(
    Function(int, int) onNominalSelected,
    Function(String, int) onPaketDataSelected,
    ) {
  final List<Map<String, dynamic>> nominalPulsa = [
    {'nominal': 5000, 'harga': 5500},
    {'nominal': 10000, 'harga': 10500},
    {'nominal': 25000, 'harga': 26000},
    {'nominal': 50000, 'harga': 51000},
    {'nominal': 100000, 'harga': 101000},
    {'nominal': 150000, 'harga': 151000},
  ];
  final List<Map<String, dynamic>> paketData = [
    {'paket': '1GB', 'harga': 15000},
    {'paket': '2GB', 'harga': 25000},
    {'paket': '5GB', 'harga': 45000},
    {'paket': '10GB', 'harga': 85000},
    {'paket': '20GB', 'harga': 160000},
    {'paket': '30GB', 'harga': 170000},
  ];

  int? selectedNominalHarga;
  String? selectedPaket;

  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pulsa',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: nominalPulsa.map((item) {
                  final isSelected = selectedNominalHarga == item['harga'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedNominalHarga = item['harga'];
                        selectedPaket = null; // Reset paket data jika pulsa dipilih
                      });
                      onNominalSelected(item['nominal'], item['harga']);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.grey
                            : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        'Rp ${item['nominal']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 40), // Space between columns
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paket Data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: paketData.map((item) {
                  final isSelected = selectedPaket == item['paket'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPaket = item['paket'];
                        selectedNominalHarga = null; // Reset pulsa jika paket data dipilih
                      });
                      onPaketDataSelected(item['paket'], item['harga']);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.grey
                            : Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        '${item['paket']} - Rp ${item['harga']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 20), // Space for the total payment section

        ],
      );
    },
  );
}

// Fungsi Untuk Total Pembayaran
Widget buildTotalPembayaran(int? selectedNominalHarga, int? selectedPaketDataHarga) {
  print('buildTotalPembayaran called');
  bool isNominalSelected = selectedNominalHarga != null;
  bool isPaketDataSelected = selectedPaketDataHarga != null;

  int total = 0;
  if (isNominalSelected) {
    total = selectedNominalHarga;
  } else if (isPaketDataSelected) {
    total = selectedPaketDataHarga;
  }

  double ppn = total * 0.11;
  double totalWithPpn = total + ppn;

  String totalHarga = 'Rp ${totalWithPpn.toStringAsFixed(0)}';
  String pajakPpn = 'Rp ${ppn.toStringAsFixed(0)}';
  String hargaAsli = 'Rp ${total.toStringAsFixed(0)}';

  return Container(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Harga ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            Text(
              hargaAsli,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pajak PPN 11%',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            Text(
              pajakPpn,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Pembayaran',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              totalHarga,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            onPressed: () {
              print('Tombol Bayar ditekan');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Text(
              'Bayar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
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
