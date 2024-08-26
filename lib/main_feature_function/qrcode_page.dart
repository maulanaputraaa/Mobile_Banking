import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({super.key});

  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  bool _isProcessing = false;
  bool _isToastVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: MobileScanner(
        fit: BoxFit.cover,
        onDetect: (BarcodeCapture capture) {
          if (capture.barcodes.isNotEmpty && !_isProcessing) {
            _handleQRCodeDetection(capture.barcodes.first);
          }
        },
      ),
    );
  }

  void _handleQRCodeDetection(Barcode barcode) async {
    setState(() {
      _isProcessing = true;
    });

    final String data = barcode.rawValue ?? '';
    print("QR Data: $data");

    if (data.isNotEmpty) {
      final Uri? uri = Uri.tryParse(data);
      if (uri != null && (uri.hasScheme && uri.hasAuthority)) {
        final String url = uri.toString();
        print("URL untuk diakses: $url");

        if (await _isUrlAccessible(url)) {
          _openUrlWithIntent(url);
        } else {
          _showToast("Link tidak dapat diakses");
        }
      } else {
        _showToast("Data tidak valid atau format URL tidak benar");
      }
    } else {
      _showToast("Data tidak ditemukan");
    }

    setState(() {
      _isProcessing = false;
    });
  }

  Future<bool> _isUrlAccessible(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      print("Status code dari URL: ${response.statusCode}");
      return response.statusCode == 200;
    } catch (e) {
      print('Error accessing URL: $e');
      return false;
    }
  }

  void _openUrlWithIntent(String url) async {
    if (Platform.isAndroid) {
      try {
        final AndroidIntent intent = AndroidIntent(
          action: 'action_view',
          data: url,
          flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
        );
        await intent.launch();
      } catch (e) {
        print('Error launching URL with intent: $e');
        _showToast("Gagal membuka link: $e");
      }
    } else {
      _showToast("Fitur ini hanya tersedia di Android");
    }
  }

  void _showToast(String message) {
    if (!_isToastVisible) {
      _isToastVisible = true;
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      ).then((_) {
        _isToastVisible = false;
      });
    }
  }
}