import 'package:flutter/material.dart';
import '../additional_feature_function/pulsa_function.dart';

class PulsaPage extends StatefulWidget {
  const PulsaPage({super.key});

  @override
  _PulsaPageState createState() => _PulsaPageState();
}

class _PulsaPageState extends State<PulsaPage> {
  final TextEditingController _nomorHpController = TextEditingController();
  final ValueNotifier<bool> _isNomorHpValidNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int?> _selectedNominalHargaNotifier = ValueNotifier<int?>(null);
  final ValueNotifier<int?> _selectedPaketDataHargaNotifier = ValueNotifier<int?>(null);

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));

    // Reset state
    _nomorHpController.clear();
    _isNomorHpValidNotifier.value = false;
    _selectedNominalHargaNotifier.value = null;
    _selectedPaketDataHargaNotifier.value = null;
  }

  void _validateOperator(String value) {
    final List<String> validCodes = ['12', '21', '46', '14', '17', '78', '96', '97', '98', '38', '31', '81', '82'];
    if (value.length >= 4 && value.startsWith('08')) {
      final String code = value.substring(2, 4);
      bool isValidOperator = validCodes.contains(code);
      _isNomorHpValidNotifier.value = isValidOperator;
    } else {
      _isNomorHpValidNotifier.value = false;
    }
  }

  @override
  void dispose() {
    _isNomorHpValidNotifier.dispose();
    _selectedNominalHargaNotifier.dispose();
    _selectedPaketDataHargaNotifier.dispose();
    super.dispose();
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
              buildNomorHP(_nomorHpController, _validateOperator),
              SizedBox(height: 40),
              ValueListenableBuilder<bool>(
                valueListenable: _isNomorHpValidNotifier,
                builder: (context, isNomorHpValid, child) {
                  return Visibility(
                    visible: isNomorHpValid,
                    child: buildPilihNominal(
                          (nominal, harga) {
                        _selectedNominalHargaNotifier.value = harga;
                        _selectedPaketDataHargaNotifier.value = null; // reset paket data jika pilih pulsa
                        print('Pulsa dipilih: Rp $nominal dengan harga Rp $harga');
                      },
                          (paket, harga) {
                        _selectedPaketDataHargaNotifier.value = harga;
                        _selectedNominalHargaNotifier.value = null; // reset pulsa jika pilih paket data
                        print('Paket data dipilih: $paket dengan harga Rp $harga');
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ValueListenableBuilder<int?>(
                valueListenable: _selectedNominalHargaNotifier,
                builder: (context, selectedNominalHarga, child) {
                  return ValueListenableBuilder<int?>(
                    valueListenable: _selectedPaketDataHargaNotifier,
                    builder: (context, selectedPaketDataHarga, child) {
                      bool hasSelection = selectedNominalHarga != null || selectedPaketDataHarga != null;
                      return Visibility(
                        visible: _isNomorHpValidNotifier.value && hasSelection,
                        child: buildTotalPembayaran(selectedNominalHarga, selectedPaketDataHarga),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }
}
