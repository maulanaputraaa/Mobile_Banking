import 'package:flutter/material.dart';
import '../additional_feature_function/bulanan_listrik_function.dart';

class BulananListrikPage extends StatelessWidget {
  const BulananListrikPage({super.key});

  Future<void> _handleRefresh() async {
    // Implementasi fungsi refresh di sini
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
            children: const [
              SizedBox(height: 20),
              BillCheckPage(),

            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }
}
