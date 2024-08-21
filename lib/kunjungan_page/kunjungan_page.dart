import 'package:flutter/material.dart';
import 'kunjungan_function.dart';

class KunjunganPage extends StatefulWidget {
  const KunjunganPage({super.key});

  @override
  _KunjunganPageState createState() => _KunjunganPageState();
}

class _KunjunganPageState extends State<KunjunganPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  //List Untuk Dummy Data
  final List<Kunjungan> _allKunjungan = [
    Kunjungan(name: 'Gita Wirayama', phoneNumber: '08123456789'),
    Kunjungan(name: 'Budi Santoso', phoneNumber: '08234567890'),
    Kunjungan(name: 'Siti Aminah', phoneNumber: '08345678901'),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  Future<void> _handleRefresh() async {
    // Implementasi fungsi refresh di sini
    await Future.delayed(Duration(seconds: 2));
    // Logika untuk memperbarui data dapat ditambahkan di sini
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
              SizedBox(height: 20),
              buildSearchBar(_searchController),
              SizedBox(height: 20),
              buildKunjunganDummy(_filteredKunjungan),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }

  List<Kunjungan> get _filteredKunjungan {
    if (_searchQuery.isEmpty) {
      return _allKunjungan;
    } else {
      return _allKunjungan.where((kunjungan) {
        return kunjungan.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            kunjungan.phoneNumber.contains(_searchQuery);
      }).toList();
    }
  }
}

class Kunjungan {
  final String name;
  final String phoneNumber;

  Kunjungan({required this.name, required this.phoneNumber});
}
