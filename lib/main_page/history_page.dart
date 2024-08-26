import 'package:flutter/material.dart';
import '../main_page_function/history_function.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, String>> _transactions = [];
  bool _isLoading = true;
  DateTimeRange? _dateRange;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await loadInitialData((transactions) {
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    }, _dateRange);
  }

  Future<void> _handleRefresh() async {
    await handleRefresh((transactions) {
      setState(() {
        _transactions = transactions;
      });
    }, _dateRange);
  }

  Future<void> _selectDateRange() async {
    await selectDateRange(context, _dateRange, (selectedRange) {
      setState(() {
        _dateRange = selectedRange;
        _isLoading = true;
      });
      _loadInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, onCalendarIconPressed: _selectDateRange),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: buildTransactionList(_transactions),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }
}
