import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main_page/login_page.dart';
import '../main_page/sign_up_page.dart';

final String dummyOtpCode = "1234";

void onOtpSubmit(BuildContext context, List<TextEditingController> otpControllers) {
  final otpInput = otpControllers.map((controller) => controller.text).join();

  if (otpInput.isEmpty) {
    showToast('Kode OTP tidak boleh kosong', false);
    return;
  } else if (otpInput != dummyOtpCode) {
    showToast('Kode OTP salah, coba lagi', false);
    return;
  }

  showToast('Kode OTP benar, proses berhasil', true);
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}

void onBackPressed(BuildContext context, PageController pageController) {
  if (pageController.page == 0) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  } else {
    pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

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

void onSubmitPhoneNumber(BuildContext context, TextEditingController phoneController, PageController pageController) {
  final phoneNumber = phoneController.text.trim();

  if (phoneNumber.isEmpty) {
    showToast('Nomor telepon tidak boleh kosong', false);
    return;
  }

  pageController.nextPage(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
}
