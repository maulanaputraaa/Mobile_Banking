import 'package:flutter/material.dart';
import 'dart:async';
import '../main_feature_function/qrcode_page.dart';
import '../main_page/account_page.dart';
import '../main_page/help_page.dart';
import '../main_page/history_page.dart';
import '../main_page/home_page.dart';

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
              'Tagihan Internet',
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

// Widget untuk halaman pengecekan tagihan
class BillCheckPage extends StatefulWidget {
  const BillCheckPage({Key? key}) : super(key: key);

  @override
  _BillCheckPageState createState() => _BillCheckPageState();
}

class _BillCheckPageState extends State<BillCheckPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();
  String _billAmount = '';
  String _taxAmount = '';
  String _totalAmount = '';

  void _checkBill() {
    if (_formKey.currentState?.validate() ?? false) {
      // Simulasi pengecekan tagihan berdasarkan nomor pelanggan
      String number = _numberController.text;
      double billAmount;

      switch (number) {
        case '123456':
          billAmount = 100000; // Tagihan untuk nomor 123456
          break;
        case '789012':
          billAmount = 200000; // Tagihan untuk nomor 789012
          break;
        case '345678':
          billAmount = 300000; // Tagihan untuk nomor 345678
          break;
        default:
          setState(() {
            _billAmount = 'Nomor pelanggan tidak ditemukan';
            _taxAmount = '';
            _totalAmount = '';
          });
          return;
      }

      // Hitung PPN 11%
      double taxAmount = billAmount * 0.11;
      double totalAmount = billAmount + taxAmount;

      setState(() {
        _billAmount = 'Rp ${billAmount.toStringAsFixed(0)}';
        _taxAmount = 'Rp ${taxAmount.toStringAsFixed(0)}';
        _totalAmount = 'Rp ${totalAmount.toStringAsFixed(0)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cek Tagihan Internet',
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          SizedBox(height: 20.0),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _numberController,
                      decoration: InputDecoration(
                        labelText: 'Nomor Pelanggan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        prefixIcon: Icon(Icons.keyboard),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor pelanggan tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _checkBill,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        'Cek Tagihan',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          if (_billAmount.isNotEmpty)
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tagihan Bulanan: $_billAmount',
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    if (_taxAmount.isNotEmpty)
                      Text(
                        'PPN (11%): $_taxAmount',
                        style: textTheme.bodyLarge,
                      ),
                    if (_totalAmount.isNotEmpty)
                      Text(
                        'Total Tagihan: $_totalAmount',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[800],
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
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
                  SizedBox(width: screenWidth * 0.15),
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
            child: const Icon(Icons.qr_code_scanner, color: Colors.lightBlueAccent, size: 40),
          ),
        ),
      ),
    ],
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
