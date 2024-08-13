import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../main_feature_function/qrcode_page.dart';
import '../main_page/account_page.dart';
import '../main_page/help_page.dart';
import '../main_page/history_page.dart';
import '../main_page/home_page.dart';
import '../screen/animate_page.dart';

PreferredSizeWidget buildAppBar(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final bool isPortrait = mediaQuery.orientation == Orientation.portrait;

  final double appBarHeight = isPortrait
      ? mediaQuery.size.height * 0.05
      : mediaQuery.size.height * 0.12;

  final double minIconSize = isPortrait ? 30.0 : 24.0;
  final double minFontSize = isPortrait ? 20.0 : 16.0;

  final double iconSize = (appBarHeight * 0.4).clamp(minIconSize, double.infinity);
  final double fontSize = (appBarHeight * 0.3).clamp(minFontSize, double.infinity);

  return PreferredSize(
    preferredSize: Size.fromHeight(appBarHeight),
    child: ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.02),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Tambah Kunjungan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: fontSize,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        elevation: 4,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.02),
            child: IconButton(
              icon: Icon(
                Icons.notifications,
                size: iconSize,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
              onPressed: () {
                // Handle notifications button press
              },
            ),
          ),
        ],
      ),
    ),
  );
}


class AddVisitForm extends StatefulWidget {
  @override
  _AddVisitFormState createState() => _AddVisitFormState();
}

class _AddVisitFormState extends State<AddVisitForm> {
  final TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  File? _image;
  bool _isDatePickerActive = false;
  String _jalan = '';
  String _kecamatan = '';
  String _kabupaten = '';
  String _provinsi = '';
  String _coordinates = '';

  @override
  void initState() {
    super.initState();
    _dateController.addListener(_onDateChanged);
    _getAddressFromGPS();
  }

  @override
  void dispose() {
    _dateController.removeListener(_onDateChanged);
    _dateController.dispose();
    super.dispose();
  }

  void _onDateChanged() {
    if (_isDatePickerActive) return;

    String text = _dateController.text.replaceAll('/', '');

    if (text.length >= 4) {
      int month = int.parse(text.substring(2, 4));
      if (month > 12) {
        text = '${text.substring(0, 2)}12${text.substring(4)}';
      }
    }

    if (text.length > 2 && text.length <= 4) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    } else if (text.length > 4) {
      text =
      '${text.substring(0, 2)}/${text.substring(2, 4)}/${text.substring(4)}';
    }

    _dateController.value = _dateController.value.copyWith(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(offset: text.length),
      ),
    );
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      // Izin diberikan, lanjutkan penyimpanan gambar
    } else {
      Fluttertoast.showToast(
        msg: 'Izin penyimpanan masih ditolak!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _getAddressFromGPS() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = placemarks[0];

      setState(() {
        _jalan = '${place.street}';
        _kecamatan = '${place.locality}';
        _kabupaten = '${place.subAdministrativeArea}';
        _provinsi = '${place.administrativeArea}';
        _coordinates =
        '${position.latitude.toStringAsFixed(6)},${position.longitude
            .toStringAsFixed(6)}';
      });
    } catch (e) {
      setState(() {
        _jalan = 'Gagal Mendapatkan Jalan';
        _kecamatan = 'Gagal Mendapatkan Kecamatan';
        _kabupaten = 'Gagal Mendapatkan kabupaten';
        _provinsi = 'Gagal Mendapatkan Provinsi';
        _coordinates = 'Gagal Mendapatkan Koordinat';
      });
    }
  }

  void _submitReport() {
    // Implement your submission logic here
    Fluttertoast.showToast(
      msg: 'Laporan kunjungan berhasil dikirim!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              hintText: 'Nama Kunjungan',
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              hintText: 'Tanggal',
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  _isDatePickerActive = true;
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  _isDatePickerActive = false;

                  if (selectedDate != null) {
                    _dateController.text = _dateFormat.format(selectedDate);
                  }
                },
              ),
            ),
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              hintText: 'Alamat',
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: _image == null
                  ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Foto Kunjungan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Klik untuk mengambil foto',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              )
                  : Stack(
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Image.file(
                      _image!,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.3,
                    ),
                  ),
                  Positioned(
                    top: 165,
                    right: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('dd MM yyyy HH:mm:ss').format(DateTime
                              .now()),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _coordinates,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _jalan,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _kecamatan,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _kabupaten,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _provinsi,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 118,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Opacity(
                        opacity: 0.7,
                        child: FlutterMap(
                          mapController: MapController(),
                          options: MapOptions(
                            initialCenter: LatLng(
                              double.tryParse(_coordinates.split(',').first) ?? 0,
                              double.tryParse(_coordinates.split(',').last) ?? 0,
                            ),
                            initialZoom: 13.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(
                                    double.tryParse(_coordinates.split(',').first) ?? 0,
                                    double.tryParse(_coordinates.split(',').last) ?? 0,
                                  ),
                                  width: 80.0,
                                  height: 80.0,
                                  child: const Icon(
                                      Icons.location_on, color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _submitReport,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 15),
              ),
              child: const Text('Kirim Laporan Kunjungan',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
  Widget buildBottomAppBar(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30.0)),
            child: Container(
              height: 60.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade700, Colors.blue.shade500],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: BottomAppBar(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(
                          Icons.home, size: 28, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).push(NoAnimationPageRoute(
                          page: HomePage(),
                        ));
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                          Icons.history, size: 28, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).push(NoAnimationPageRoute(
                          page: HistoryPage(),
                        ));
                      },
                    ),
                    SizedBox(width: screenWidth * 0.15),
                    IconButton(
                      icon: const Icon(
                          Icons.help_outline, size: 28, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).push(NoAnimationPageRoute(
                          page: const HelpPage(),
                        ));
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                          Icons.person_outline, size: 28, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).push(NoAnimationPageRoute(
                          page: const AccountPage(),
                        ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: -20,
          left: (screenWidth - 70) / 2,
          child: SizedBox(
            width: 70,
            height: 70,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ScanQRPage(),
                ));
              },
              backgroundColor: Colors.white,
              elevation: 5,
              shape: const CircleBorder(),
              child: const Icon(
                  Icons.qr_code_scanner, color: Colors.lightBlueAccent,
                  size: 40),
            ),
          ),
        ),
      ],
    );
  }