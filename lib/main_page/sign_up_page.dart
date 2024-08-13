import 'package:coba/main_page/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main_page/login_page.dart';
import '../main_page_function/sign_up_function.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _showPassword = false; // Variabel untuk mengontrol tampilan password
  bool _showConfirmPassword = false; // Variabel untuk mengontrol tampilan konfirmasi password

  void _onRegisterPressed() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    //Validasi semua field harus terisi
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showToast('Semua field harus diisi');
      return;
    }

    // Validasi email
    if (!EmailValidator.validate(email)) {
      showToast('Format email tidak valid');
      return;
    }

    // Validasi password
    if (password.length < 8) {
      showToast('Password harus memiliki minimal 8 karakter');
      return;
    }

    if (!isStrongPassword(password)) {
      showToast('Password harus mengandung huruf besar, huruf kecil, angka, dan simbol');
      return;
    }

    if (password != confirmPassword) {
      showToast('Password tidak cocok');
      return;
    }

    // Jika semua validasi berhasil, navigasi ke halaman login
    Fluttertoast.showToast(
      msg: 'Registrasi berhasil',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OTPPage()),
    );
  }

  void showToast(String message) {
    print('Showing toast with message: $message'); // Tambahkan log untuk debugging
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }


  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isKeyboardVisible = mediaQuery.viewInsets.bottom > 0;
    final double paddingBottom = isKeyboardVisible ? mediaQuery.viewInsets.bottom : 20.0;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.lightBlueAccent,
                Colors.greenAccent,
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.05),
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: mediaQuery.size.width * 0.8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: header(context),
                    ),
                    // Pendaftaran
                    Container(
                      margin: EdgeInsets.only(bottom: paddingBottom),
                      child: Column(
                        children: [
                          inputFields(
                              context,
                              emailController,
                              passwordController,
                              confirmPasswordController,
                              _showPassword,
                              _showConfirmPassword,
                              _togglePasswordVisibility,
                              _toggleConfirmPasswordVisibility
                          ),
                          const SizedBox(height: 20), // Jarak sebelum tombol registrasi
                          signUpButton(
                            context,
                            emailController,
                            passwordController,
                            confirmPasswordController,
                            _onRegisterPressed,
                          ),
                        ],
                      ),
                    ),
                    // Login
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: signIn(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Fungsi validasi password
bool isStrongPassword(String password) {
  final hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
  final hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
  final hasDigits = RegExp(r'\d').hasMatch(password);
  final hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  return hasUpperCase && hasLowerCase && hasDigits && hasSpecialCharacters;
}
