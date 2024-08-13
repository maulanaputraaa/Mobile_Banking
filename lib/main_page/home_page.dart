import 'package:flutter/material.dart';
import '../main_page_function/home_function.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isRefreshing = false;

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });
    // Simulasi proses refresh
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isRefreshing = false;
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
              SizedBox(height: 20),
              BalanceContainer(),
              SizedBox(height: 30),
              buildMainFeatureContainers(context),
              SizedBox(height: 40,),
              buildSingleFeatureContainer(context),
              SizedBox(height: 40,),
              buildAdBanner(context),
              SizedBox(height: 420,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }
}
