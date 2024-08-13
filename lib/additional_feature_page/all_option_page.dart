import 'package:flutter/material.dart';
import '../additional_feature_function/all_option_function.dart';

class AllOptionPage extends StatefulWidget {
  const AllOptionPage({super.key});

  @override
  _AllOptionPageState createState() => _AllOptionPageState();
}

class _AllOptionPageState extends State<AllOptionPage> {
  String _searchQuery = '';

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
              const SizedBox(height: 20,),
              AllOptionFunctions.buildSearchBar(
                  onChanged: (String value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  }
              ),
              const SizedBox(height: 20,),
              AllOptionFunctions.buildAdditionalSection(context, _searchQuery),
              const SizedBox(height: 500,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }
}
