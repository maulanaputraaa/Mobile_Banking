import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Tambahkan import ini

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
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
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
              ),
              SizedBox(width: mediaQuery.size.width * 0.02),
              Text(
                'Informasi Rekening',
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
            ],
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
      ),
    ),
  );
}

class RekeningFunctions {
  static Widget buildSettingsSection(BuildContext context) {
    return Column(
      children: [
        buildSettingItem(context, 'Nomor Rekening', '328 0402 922', true),
        buildSettingItem(context, 'Nomor Kartu', '6019 0052 2465 1625', true),
        buildSettingItem(context, 'Nama Rekening', 'Wahyu Nur Cahyo', false),
        buildSettingItem(context, 'Nama Alias', 'Bank Haji', false),
        buildSettingItem(context, 'Status Finansial', 'Unlimited Saldo', false),
        buildSettingItem(context, 'Email', 'wnc@gmail.com', false),
        buildSettingItem(context, 'Status Rekening', 'Pribadi', false),
        buildSettingItem(context, 'Status kartu', 'Seumur Hidup', false),
      ],
    );
  }

  static Widget buildSettingItem(BuildContext context, String title, String value, bool showArrow) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value.isNotEmpty)
            Text(
              value,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          const SizedBox(width: 5),
          if (showArrow)
            IconButton(
              icon: const Icon(Icons.copy, size: 20),
              onPressed: () {
                // Menyalin teks ke clipboard
                Clipboard.setData(ClipboardData(text: value)).then((_) {
                  // Menampilkan snackbar sebagai umpan balik
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$title disalin ke clipboard'),
                    ),
                  );
                });
              },
            ),
        ],
      ),
      onTap: () {
        // Handle tap
      },
    );
  }
}
