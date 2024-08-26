import 'package:flutter/material.dart';
import '../main_feature_function/transfer_function.dart';// Import file transfer_function.dart

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

@override
_TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  Future<void> _handleRefresh() async {
    // Implementasi fungsi refresh di sini
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      // Update data atau state yang diperlukan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,),
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
            children: [
              buildTransferOptions(),
            ],
          ),
        ),
      ),
    );
  }
}

