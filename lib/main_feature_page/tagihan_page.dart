import 'package:flutter/material.dart';

import '../main_feature_function/tagihan_function.dart';

class TagihanPage extends StatefulWidget {
  const TagihanPage({super.key});

  @override
  _TagihanPageState createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {
  Future<void> _handleRefresh() async {
    // Implementasi fungsi refresh di sini
    await Future.delayed(Duration(seconds: 2));
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
              const SizedBox(height: 20,),
              buildTagihanOptions(context),
            ],
          ),
        ),
      ),
    );
  }
}

