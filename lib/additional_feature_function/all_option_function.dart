import 'package:coba/additional_feature_page/e_money_page.dart';
import 'package:coba/additional_feature_page/internet_page.dart';
import 'package:coba/additional_feature_page/listrik_page.dart';
import 'package:coba/additional_feature_page/pulsa_page.dart';
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
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
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
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
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

class AllOptionFunctions {
  static Widget buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Row(
      ),
    );
  }

  // Fungsi untuk membangun Search Bar
  static Widget buildSearchBar({required ValueChanged<String> onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
        ),
        onChanged: onChanged,
      ),
    );
  }

  static Widget buildAdditionalSection(BuildContext context, String searchQuery) {
    final sections = {
      'Telekomunikasi': {
        'Pascabayar': 'assets/icon/handpone_icon.png',
        'Pulsa/Data': 'assets/icon/paket_data_icon.png',
      },
      'Beli/Bayar Tagihan': {
        'Listrik': 'assets/icon/listrik_icon.png',
        'PDAM': 'assets/icon/air_icon.png',
        'TV Kabel & Internet': 'assets/icon/tv_icon.png',
        'Gas': 'assets/icon/gas_icon.png',
        'Voucher': 'assets/icon/voucher_icon.png',
        'Telepon': 'assets/icon/telephone_icon.png',
        'Properti': 'assets/icon/properti_icon.png',
        'Pendidikan': 'assets/icon/pendidikan_icon.png',
      },
      'Transportasi': {
        'Kapal': 'assets/icon/kapal_icon.png',
        'Parkir': 'assets/icon/parkir_icon.png',
        'Kereta': 'assets/icon/kereta_icon.png',
        'Taksi': 'assets/icon/taksi_icon.png',
        'Bus': 'assets/icon/bus_icon.png',
        'Pesawat': 'assets/icon/pesawat_icon.png',
        'Kendaraan Online': 'assets/icon/kendaraan_online_icon.png',
      },
      'Kartu Uang Elektronik': {
        'Kartu Uang Elektronik': 'assets/icon/e-money_icon.png',
      },
      'Keuangan': {
        'Tabungan Emas': 'assets/icon/emas_icon.png',
        'Pinjaman': 'assets/icon/pinjaman_icon.png',
        'Cicilan': 'assets/icon/promo_icon.png',
        'Pegadaian': 'assets/icon/pegadaian_icon.png',
        'Rekening Online': 'assets/icon/rekening_icon.png',
        'Asuransi': 'assets/icon/asuransi_icon.png',
        'BPJS': 'assets/icon/rumah_sakit_icon.png',
        'Reksa Dana': 'assets/icon/trading_icon.png',
      },
      'Travel dan Hiburan': {
        'Streaming': 'assets/icon/streaming_icon.png',
        'Travel dan Hotel': 'assets/icon/hotel_icon.png',
        'Voucher Games': 'assets/icon/voucher_icon.png',
        'Mgames': 'assets/icon/google_play_icon.png',
      },
      'Dana Sosial': {
        'Infaq': 'assets/icon/infaq_icon.png',
        'Zakat': 'assets/icon/zakat_icon.png',
        'Wakaf': 'assets/icon/donasi_icon.png',
        'Masjid': 'assets/icon/masjid_icon.png',
        'Gereja': 'assets/icon/gereja_icon.png',
        'Bonasi Lainnya': 'assets/icon/donasi_2_icon.png',
        'Bantu Sesama': 'assets/icon/bantu_sesama_icon.png',
      },
      'Pajak': {
        'Samsat Digital Nasional': 'assets/icon/samsat_icon.png',
        'Bayar KUA': 'assets/icon/masjid_icon.png',
        'Bayar Paspor': 'assets/icon/paspor_icon.png',
        'Bayar SIM': 'assets/icon/sim_icon.png',
        'Bayar Denda Tilang': 'assets/icon/polisi_icon.png',
        'Bayar Beacukai': 'assets/icon/beacukai_icon.png',
        'Bayar PPH': 'assets/icon/pph_icon.png',
        'Bayar PPN': 'assets/icon/ppn_icon.png',
        'Laporan Perpajakan': 'assets/icon/laporan_pajak_icon.png',
        'Pajak': 'assets/icon/pajak_2_icon.png',
        'Retribusi': 'assets/icon/retribusi_icon.png',
        'E-Samsat': 'assets/icon/samsat_icon.png',
      },
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            final bool isPortrait = orientation == Orientation.portrait;
            final int crossAxisCount = isPortrait ? 4 : 6;

            // Filter sections based on searchQuery
            final filteredSections = Map.fromEntries(
              sections.entries.map((entry) {
                final filteredOptions = Map.fromEntries(
                  entry.value.entries.where((optionEntry) =>
                      optionEntry.key.toLowerCase().contains(searchQuery.toLowerCase())),
                );
                return MapEntry(entry.key, filteredOptions);
              }).where((entry) => entry.value.isNotEmpty),
            );

            return Column(
              children: filteredSections.entries.map((entry) {
                return buildSettingItem(context, entry.key, entry.value, crossAxisCount: crossAxisCount);
              }).toList(),
            );
          },
        );
      },
    );
  }

  static Widget buildSettingItem(BuildContext context, String title, Map<String, String> options,
      {Color color = Colors.black, required int crossAxisCount}) {
    return ExpansionTile(
      title: Text(title),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 0.9,
            children: options.entries.map((entry) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Image.asset(entry.value, width: 30, height: 30),
                    onPressed: () {
                      if (entry.key == 'Listrik') {
                        Navigator.push(
                          context,
                          NoAnimationPageRoute(
                            page: const ListrikPage(),
                          ),
                        );
                      }
                      if (entry.key == 'Kartu Uang Elektronik') {
                        Navigator.push(
                          context,
                          NoAnimationPageRoute(
                            page: const EMoneyPage(),
                          ),
                        );
                      }
                      if (entry.key == 'TV Kabel & Internet') {
                        Navigator.push(
                          context,
                          NoAnimationPageRoute(
                            page: const InternetPage(),
                          ),
                        );
                      }
                      if (entry.key == 'Pulsa/Data') {
                        Navigator.push(
                          context,
                          NoAnimationPageRoute(
                            page: const PulsaPage(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    entry.key,
                    style: TextStyle(fontSize: 10, color: color),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
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
                        page: const HelpPage(),
                      ));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_outline, size: 28, color: Colors.white),
                    onPressed: () {
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
      Positioned(
        top: -20, // Jarak dari bagian atas
        left: (screenWidth - 70) / 2, // Posisi horizontal, agar berada di tengah
        child: SizedBox(
          width: 70, // Lebar FAB
          height: 70, // Tinggi FAB
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScanQRPage(),
              ));
            },
            backgroundColor: Colors.white,
            elevation: 5,
            shape: const CircleBorder(),
            child: const Icon(Icons.qr_code_scanner, color: Colors.lightBlueAccent, size: 40),
          ),
        ),
      ),
    ],
  );
}
