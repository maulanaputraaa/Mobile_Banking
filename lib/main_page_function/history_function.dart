import 'package:flutter/material.dart';
import 'dart:math';
import '../main_feature_function/qrcode_page.dart';
import '../main_page/account_page.dart';
import '../main_page/help_page.dart';
import '../main_page/history_page.dart';
import '../main_page/home_page.dart';
import '../screen/animate_page.dart';

//Widget Untuk AppBar
PreferredSizeWidget buildAppBar(BuildContext context, {VoidCallback? onCalendarIconPressed}) {
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
              'Bank Haji',
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
                Icons.calendar_month,
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
              onPressed: onCalendarIconPressed,
            ),
          ),
        ],
      ),
    ),
  );
}

//Fungsi Untuk Data Transaksi Dummy
Future<List<Map<String, String>>> fetchTransactions({DateTimeRange? dateRange}) async {
  await Future.delayed(const Duration(seconds: 2)); // Simulasi delay
  final random = Random();
  final startDate = DateTime(2000, 1, 1);
  final totalDays = DateTime.now().difference(startDate).inDays;

  final transactions = List.generate(5000, (index) {
    final date = startDate.add(Duration(days: random.nextInt(totalDays)));
    final formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    final isNegative = random.nextBool();
    final randomAmountFactor = (date.millisecondsSinceEpoch % 1000) + 100;
    final amount = '${isNegative ? '-' : '+'}Rp.$randomAmountFactor.000';

    final description = isNegative ? 'Pengeluaran' : 'Pemasukan';

    return {
      'date': formattedDate,
      'amount': amount,
      'description': description,
      'isNegative': isNegative.toString(),
    };
  });

  // Mengurutkan transaksi dari yang terbaru ke terlama
  transactions.sort((a, b) => b['date']!.compareTo(a['date']!));

  // Mengupdate deskripsi transaksi
  int incomeCounter = 0;
  int expenseCounter = 0;

  for (var transaction in transactions) {
    if (transaction['isNegative'] == 'true') {
      expenseCounter++;
      transaction['description'] = 'Pengeluaran $expenseCounter';
    } else {
      incomeCounter++;
      transaction['description'] = 'Pemasukan $incomeCounter';
    }
  }

  if (dateRange != null) {
    return transactions.where((transaction) {
      final date = DateTime.parse(transaction['date']!);
      return dateRange.start.isBefore(date) && date.isBefore(dateRange.end);
    }).toList();
  }

  return transactions;
}

//Fungsi Untuk Mengambil data
Future<void> loadInitialData(Function(List<Map<String, String>>) onDataLoaded, DateTimeRange? dateRange) async {
  final transactions = await fetchTransactions(dateRange: dateRange);
  onDataLoaded(transactions);
}

//Fungsi Untuk Real Time Refresh
Future<void> handleRefresh(Function(List<Map<String, String>>) onDataLoaded, DateTimeRange? dateRange) async {
  final transactions = await fetchTransactions(dateRange: dateRange);
  onDataLoaded(transactions);
}

//Fungsi Untuk Melakukan Filter Riwayat
Future<void> selectDateRange(
    BuildContext context,
    DateTimeRange? currentDateRange,
    Function(DateTimeRange) onDateRangeSelected,
    ) async {
  final now = DateTime.now();
  final farPastDate = DateTime(1900, 1, 1);

  final selectedRange = await showDateRangePicker(
    context: context,
    firstDate: farPastDate,
    lastDate: now,
    initialDateRange: currentDateRange ?? DateTimeRange(
      start: now.subtract(const Duration(days: 365)),
      end: now,
    ),
  );

  if (selectedRange != null) {
    onDateRangeSelected(selectedRange);
  }
}

//Widget Untuk Transaksi
Widget buildTransactionList(List<Map<String, String>> transactions) {
  return ListView.builder(
    itemCount: transactions.length,
    itemBuilder: (context, index) {
      final transaction = transactions[index];
      final isNegative = transaction['amount']!.startsWith('-');

      return ListTile(
        title: Text(transaction['description']!),
        subtitle: Text(transaction['date']!),
        trailing: Text(
          transaction['amount']!,
          style: TextStyle(
            color: isNegative ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    },
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
