import 'package:flutter/material.dart';
import '../additional_feature_function/token_listrik_function.dart';

class TokenListrikPage extends StatefulWidget {
  @override
  _TokenListrikPageState createState() => _TokenListrikPageState();
}

class _TokenListrikPageState extends State<TokenListrikPage> {
  final TextEditingController _nomorPelangganController = TextEditingController();
  String? _selectedNominal;
  double? _tokenPrice;
  double? _ppn;
  double? _totalPrice;

  void _onNominalSelected(String nominal) {
    setState(() {
      _selectedNominal = nominal;
      _tokenPrice = getTokenPrice(nominal);
      _ppn = calculatePPN(_tokenPrice!);
      _totalPrice = calculateTotalPrice(_tokenPrice!, _ppn!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildNomorPelangganTextField(_nomorPelangganController),
            const SizedBox(height: 20),
            if (_nomorPelangganController.text.isNotEmpty)
              buildNominalOptions(_onNominalSelected),
            const SizedBox(height: 20),
            if (_selectedNominal != null) buildPriceContainer(),
            const SizedBox(height: 20),
            if (_selectedNominal != null) buildSubmitButton(context),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }

  Widget buildPriceContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Harga Token: Rp ${_tokenPrice!.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'PPN (11%): Rp ${_ppn!.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total Pembayaran: Rp ${_totalPrice!.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }


}
