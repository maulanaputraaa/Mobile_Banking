import 'package:coba/additional_feature_page/internet_page.dart';
import 'package:flutter/material.dart';

import '../additional_feature_page/listrik_page.dart';

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
                'Tagihan',
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

// Fungsi untuk menampilkan ikon dan teks tanpa container
Widget buildTagihanOptions(BuildContext context) {
  return GridView.count(
    shrinkWrap: true,
    crossAxisCount: 4,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    children: [
      buildGridItem(
        'Pascabayar',
        'assets/icon/handpone_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
      buildGridItem(
        'BPJS',
        'assets/icon/rumah_sakit_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
      buildGridItem(
        'Listrik',
        'assets/icon/listrik_icon.png',
            () {
              Navigator.of(context).push(NoAnimationPageRoute(
                page: const ListrikPage(),
              ));
        },
      ),
      buildGridItem(
        'PDAM',
        'assets/icon/air_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
      buildGridItem(
        'Kartu Kredit',
        'assets/icon/kartu_kredit_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
      buildGridItem(
        'KAI',
        'assets/icon/kereta_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
      buildGridItem(
        'Pendidikan',
        'assets/icon/pendidikan_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
      buildGridItem(
        'TV Kabel',
        'assets/icon/tv_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
      buildGridItem(
        'Asuransi',
        'assets/icon/asuransi_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
      buildGridItem(
        'Pajak Daerah',
        'assets/icon/pajak_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
      buildGridItem(
        'Telkom',
        'assets/icon/telephone_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
      buildGridItem(
        'Samsat',
        'assets/icon/samsat_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
      buildGridItem(
        'Properti',
        'assets/icon/properti_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
      buildGridItem(
        'Internet',
        'assets/icon/internet_icon.png',
            () {
              Navigator.of(context).push(NoAnimationPageRoute(
                page: const InternetPage(),
              ));
        },
      ),
      buildGridItem(
        'E-Commerce',
        'assets/icon/e_commerce_icon.png',
            () {
          // Aksi saat diklik
        },
      ),
    ],
  );
}

Widget buildGridItem(String title, String assetPath, VoidCallback onTap, {double inkWellRadius = 16.0}) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isTapped = false;

      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(90),
        child: InkResponse(
          onTap: () {
            setState(() {
              isTapped = !isTapped;
            });
            onTap();
          },
          highlightShape: BoxShape.rectangle,
          radius: inkWellRadius,
          splashColor: Colors.black.withOpacity(0.1),
          highlightColor: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(90.0),
          child: AnimatedScale(
            scale: isTapped ? 0.9 : 1.0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            child: Center( // Add this Center widget
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    assetPath,
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center, // Center text horizontally
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

class NoAnimationPageRoute extends MaterialPageRoute {
  NoAnimationPageRoute({required Widget page})
      : super(builder: (BuildContext context) => page);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;
  }
}