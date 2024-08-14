import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main_page/login_page.dart';
import '../main_page/sign_up_page.dart';

// Kode OTP dummy untuk verifikasi
const String dummyOtpCode = "1234";

/// Menangani pengiriman OTP dengan memverifikasi input
void onOtpSubmit(BuildContext context, List<TextEditingController> otpControllers) {
  // Menggabungkan nilai dari semua controller OTP
  final otpInput = otpControllers.map((controller) => controller.text).join();

  // Mengecek apakah input kosong
  if (otpInput.isEmpty) {
    showToast('Kode OTP tidak boleh kosong', false);
    return;
  }
  // Mengecek apakah kode OTP yang dimasukkan benar
  else if (otpInput != dummyOtpCode) {
    showToast('Kode OTP salah, coba lagi', false);
    return;
  }

  // Menampilkan pesan sukses dan berpindah ke halaman login
  showToast('Kode OTP benar, proses berhasil', true);
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
}

/// Menangani aksi tombol kembali pada halaman OTP
void onBackPressed(BuildContext context, PageController pageController) {
  // Jika berada di halaman pertama, kembali ke halaman pendaftaran
  if (pageController.page == 0) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }
  // Jika berada di halaman lain, kembali ke halaman sebelumnya
  else {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

/// Menampilkan toast dengan pesan dan warna yang sesuai
void showToast(String message, bool isSuccess) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

/// Menangani pengiriman nomor telepon dan berpindah ke halaman berikutnya
void onSubmitPhoneNumber(BuildContext context, TextEditingController phoneController, PageController pageController) {
  final phoneNumber = phoneController.text.trim();

  // Mengecek apakah nomor telepon kosong
  if (phoneNumber.isEmpty) {
    showToast('Nomor telepon tidak boleh kosong', false);
    return;
  }

  // Berpindah ke halaman berikutnya
  pageController.nextPage(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
}
