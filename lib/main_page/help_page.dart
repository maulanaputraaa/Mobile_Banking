import 'package:flutter/material.dart';
import '../main_page_function/help_function.dart';


class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  Future<void> _handleRefresh() async {
    // Implementasi fungsi refresh di sini
    await Future.delayed(const Duration(seconds: 2)); // Simulasi delay untuk refresh

    // Jika Anda perlu memperbarui data, lakukan di sini
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
            children: [
              const SizedBox(height: 20,),
              HelpFunctions.buildSearchBar(),
              const SizedBox(height: 20,),
              HelpFunctions.buildAdditionalSection(),
              const SizedBox(height: 400),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }
}
