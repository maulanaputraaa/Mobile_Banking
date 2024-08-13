import 'package:flutter/material.dart';
import '../additional_feature_function/all_option_function.dart';

class AllOptionPage extends StatelessWidget {
  const AllOptionPage({super.key});

  Future<void> _handleRefresh() async {
    // Implementasi fungsi refresh di sini
    await Future.delayed(Duration(seconds: 2));
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
              SizedBox(height: 20,),
              AllOptionFunctions.buildSearchBar(),
              SizedBox(height: 20,),
              AllOptionFunctions.buildAdditionalSection(context),
              SizedBox(height: 500,)
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }
}
