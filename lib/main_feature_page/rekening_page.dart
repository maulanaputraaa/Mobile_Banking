import 'package:flutter/material.dart';
import '../main_feature_function/rekening_function.dart';

class RekeningPage extends StatelessWidget {
  const RekeningPage({super.key});

  Future<void> _handleRefresh() async {
    // Implementasi fungsi refresh di sini
    await Future.delayed(const Duration(seconds: 2));
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
              const SizedBox(height: 20,),
              RekeningFunctions.buildSettingsSection(context),
          ]
          ),
        ),
      ),
    );
  }
}
