import 'package:flutter/material.dart';
import '../main_page_function/account_function.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

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
              AccountFunctions.buildProfileHeader(),
              AccountFunctions.buildSettingsSection(),
              const SizedBox(height: 49,),
              AccountFunctions.buildSignOutButton(context),
              const SizedBox(height: 200,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }
}
