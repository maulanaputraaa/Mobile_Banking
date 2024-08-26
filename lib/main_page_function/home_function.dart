import 'package:coba/additional_feature_page/e_money_page.dart';
import 'package:coba/kunjungan_page/kunjungan_page.dart';
import 'package:coba/additional_feature_page/listrik_page.dart';
import 'package:coba/additional_feature_page/pulsa_page.dart';
import 'package:coba/location_tracking/location_tracking_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../additional_feature_page/all_option_page.dart';
import '../main_feature_function/qrcode_page.dart';
import '../main_feature_page/rekening_page.dart';
import '../main_feature_page/tagihan_page.dart';
import '../main_feature_page/transfer_page.dart';
import '../main_page/account_page.dart';
import '../main_page/help_page.dart';
import '../main_page/history_page.dart';
import '../main_page/home_page.dart';
import '../screen/animate_page.dart';

// Fungsi untuk membangun RefreshIndicator
Widget buildRefreshIndicator(Widget child, Future<void> Function() onRefresh) {
  return RefreshIndicator(
    onRefresh: onRefresh,
    child: child,
  );
}

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

// Fungsi untuk membangun Container Saldo
class BalanceContainer extends StatefulWidget {
  const BalanceContainer({super.key});

  @override
  _BalanceContainerState createState() => _BalanceContainerState();
}

class _BalanceContainerState extends State<BalanceContainer> {
  bool _isBalanceVisible = true;

  void _toggleBalanceVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian atas kartu
          Row(
            children: [
              Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'ATM',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.credit_card,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).push(NoAnimationPageRoute(
                    page: const RekeningPage(),
                  ));
                },
              )
            ],
          ),
          const SizedBox(height: 10),
          // Saldo
          const Text(
            'Saldo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isBalanceVisible ? 'Rp 123.456.789' : '•••••',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(
                  _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: _toggleBalanceVisibility,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Nomor rekening
          const Text(
            'Nomor Rekening: 328 0402 922',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// Fungsi untuk membangun Container Fitur
Widget buildMainFeatureContainers(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  final screenWidth = MediaQuery.of(context).size.width;

  // Menghitung lebar kontainer berdasarkan lebar layar
  double containerWidth;
  double containerHeight;

  if (orientation == Orientation.portrait) {
    containerWidth = screenWidth / 5;
    containerHeight = containerWidth * 0.8125; // Rasio 5:4
  } else {
    containerWidth = screenWidth / 8;
    containerHeight = containerWidth * 0.8125; // Rasio 5:4
  }

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MainFeatureContainer(
            width: containerWidth,
            height: containerHeight,
            image: const AssetImage('assets/icon/transfer_icon.png'),
            label: 'Transfer',
            onTap: () {
              Navigator.of(context).push(NoAnimationPageRoute(
                page: const TransferPage(),
              ));
            },
          ),
          MainFeatureContainer(
            width: containerWidth,
            height: containerHeight,
            image: const AssetImage('assets/icon/bank_icon.png'),
            label: 'Rekening',
            onTap: () {
              Navigator.of(context).push(NoAnimationPageRoute(
                page: const RekeningPage(),
              ));
            },
          ),
          MainFeatureContainer(
            width: containerWidth,
            height: containerHeight,
            image: const AssetImage('assets/icon/tagihan_icon.png'),
            label: 'Tagihan',
            onTap: () {
              Navigator.of(context).push(NoAnimationPageRoute(
              page: const TagihanPage(),
              ));
            },
          ),
          MainFeatureContainer(
            width: containerWidth,
            height: containerHeight,
            image: const AssetImage('assets/icon/mutasi_icon.png'),
            label: 'Mutasi',
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MutasiPage()),
              // );
            },
          ),
        ],
      ),
    ],
  );
}

// Widget untuk Container Fitur
class MainFeatureContainer extends StatelessWidget {
  final double width;
  final double height;
  final ImageProvider image; // Mengganti IconData dengan ImageProvider
  final String label;
  final VoidCallback onTap;

  const MainFeatureContainer({super.key,
    required this.width,
    required this.height,
    required this.image,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: image,
              width: width * 0.3, // Menyesuaikan ukuran gambar dengan lebar kontainer
              height: width * 0.3, // Menyesuaikan ukuran gambar dengan lebar kontainer
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.125, // Menyesuaikan ukuran teks dengan lebar kontainer
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Fungsi untuk membangun Container Fitur Tunggal
Widget buildSingleFeatureContainer(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double iconSize = screenWidth * 0.07;
  final double paddingValue = screenWidth * 0.05;

  return Container(
    padding: EdgeInsets.symmetric(vertical: paddingValue, horizontal: paddingValue),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(4, 4),
        ),
      ],
    ),
    clipBehavior: Clip.hardEdge,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: SingleFeature(
              iconPath: 'assets/icon/handpone_icon.png',
              label: 'Pulsa',
              iconSize: iconSize,
              onTap: () {
                Navigator.of(context).push(NoAnimationPageRoute(
                  page: const PulsaPage(),
                ));
              },)),
            SizedBox(width: paddingValue / 2),
            Expanded(child: SingleFeature(
              iconPath: 'assets/icon/listrik_icon.png',
              label: 'Listrik',
              iconSize: iconSize,
              onTap: () {
                Navigator.of(context).push(NoAnimationPageRoute(
                  page: const ListrikPage(),
                ));
              },)),
            SizedBox(width: paddingValue / 2),
            Expanded(child: SingleFeature(
              iconPath: 'assets/icon/paket_data_icon.png',
              label: 'Paket Data',
              iconSize: iconSize,
              onTap: () {
                Navigator.of(context).push(NoAnimationPageRoute(
                  page: const PulsaPage(),
                ));
              },)),
            SizedBox(width: paddingValue / 2),
            Expanded(child: SingleFeature(
              iconPath: 'assets/icon/e-money_icon.png',
              label: 'E-money',
              iconSize: iconSize,
              onTap: () {
                Navigator.of(context).push(NoAnimationPageRoute(
                  page: const EMoneyPage(),
                ));
              },)),
          ],
        ),
        SizedBox(height: paddingValue),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: SingleFeature(
              iconPath: 'assets/icon/google_play_icon.png',
              label: 'Play',
              iconSize: iconSize,
              onTap: () {

              },)),
            SizedBox(width: paddingValue / 2),
            Expanded(child: SingleFeature(
              iconPath: 'assets/icon/voucher_icon.png',
              label: 'Voucher',
              iconSize: iconSize,
              onTap: () {
                Navigator.of(context).push(NoAnimationPageRoute(
                  page: const LocationTrackingScreen(),
                ));
              },)),
            SizedBox(width: paddingValue / 2),
            Expanded(child: SingleFeature(
              iconPath: 'assets/icon/promo_icon.png',
              label: 'Promo',
              iconSize: iconSize,
              onTap: () {
                Navigator.of(context).push(NoAnimationPageRoute(
                  page: const KunjunganPage(),
                ));
              },)),
            SizedBox(width: paddingValue / 2),
            Expanded(child: SingleFeature(
              iconPath: 'assets/icon/lainnya_icon.png',
              label: 'Lainnya',
              iconSize: iconSize,
              onTap: () {
                Navigator.of(context).push(NoAnimationPageRoute(
                  page: const AllOptionPage(),
                ));
              },
            )),
          ],
        ),
      ],
    ),
  );
}

// Widget untuk Fitur Tunggal
class SingleFeature extends StatelessWidget {
  final String iconPath;
  final String label;
  final double iconSize;
  final VoidCallback onTap;

  const SingleFeature({super.key, 
    required this.iconPath,
    required this.label,
    required this.iconSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.black.withOpacity(0.2),
        splashColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(90.00),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: iconSize,
                height: iconSize,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: iconSize * 0.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Fungsi untuk membangun Container Iklan dengan animasi geser otomatis
Widget buildAdBanner(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      const aspectRatio = 16 / 9;
      final maxHeight = screenHeight * 0.2;
      final height = screenWidth / aspectRatio;

      return Container(
        height: height < maxHeight ? height : maxHeight,
        margin: const EdgeInsets.symmetric(horizontal: 0.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: AdBannerSlider(
          ads: [
            AdBannerItem(image: 'assets/ads/1.png'),
            AdBannerItem(image: 'assets/ads/2.png'),
            AdBannerItem(image: 'assets/ads/3.png'),
            AdBannerItem(image: 'assets/ads/4.png'),
            AdBannerItem(image: 'assets/ads/5.png'),
          ],
        ),
      );
    },
  );
}

// Kelas untuk item iklan
class AdBannerItem {
  final String? image;
  final String? text;

  AdBannerItem({this.image, this.text});
}

// Widget untuk AdBannerSlider
class AdBannerSlider extends StatefulWidget {
  final List<AdBannerItem> ads;

  const AdBannerSlider({super.key, required this.ads});

  @override
  _AdBannerSliderState createState() => _AdBannerSliderState();
}

class _AdBannerSliderState extends State<AdBannerSlider> {
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        final nextPage = (_pageController.page!.toInt() + 1) % widget.ads.length;
        _pageController.animateToPage(nextPage, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: widget.ads.length,
          itemBuilder: (context, index) {
            final adItem = widget.ads[index];
            return LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                final screenHeight = constraints.maxHeight;

                const aspectRatio = 16 / 9;
                final maxHeight = screenHeight * 0.2;
                final height = screenWidth / aspectRatio;

                return Container(
                  width: screenWidth,
                  height: height < maxHeight ? height : maxHeight,
                  color: Colors.transparent,
                  child: Center(
                    child: adItem.image != null
                        ? Image.asset(
                      adItem.image!,
                      fit: BoxFit.cover,
                    )
                        : Text(
                      adItem.text!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 10,
          child: SmoothPageIndicator(
            controller: _pageController,
            count: widget.ads.length,
            effect: WormEffect(
              dotColor: Colors.black.withOpacity(0.5),
              activeDotColor: Colors.blue,
              dotHeight: 8.0,
              dotWidth: 8.0,
              spacing: 8.0,
            ),
            onDotClicked: (index) {
              _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
          ),
        ),
      ],
    );
  }
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
                        page: const HomePage(),
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
                        page: const HistoryPage(),
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
