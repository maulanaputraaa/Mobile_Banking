import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import '../main_page/home_page.dart';
import '../main_page/sign_up_page.dart';

/// Layanan autentikasi biometrik
class AuthService {
  final LocalAuthentication auth = LocalAuthentication();

  /// Mengautentikasi pengguna menggunakan biometrik (sidik jari)
  Future<bool> authenticateWithBiometrics() async {
    try {
      // Memeriksa apakah biometrik dapat diperiksa
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool canAuthenticate = canCheckBiometrics || await auth.isDeviceSupported();

      if (!canAuthenticate) {
        return false;
      }

      // Melakukan autentikasi biometrik
      bool authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      return authenticated;
    } on PlatformException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Memeriksa apakah perangkat mendukung biometrik
  Future<bool> checkBiometrics() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    return canCheckBiometrics;
  }
}

/// Widget header yang menampilkan gambar
Widget header(BuildContext context) {
  return Container(
    width: 180,
    height: 180,
    margin: const EdgeInsets.symmetric(vertical: 20),
    child: Image.asset(
      'assets/image/bankv2.png',
      fit: BoxFit.contain,
    ),
  );
}

/// Widget untuk field password dengan kemampuan untuk menampilkan/menyembunyikan password
class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscurePassword = true;

  /// Mengubah visibilitas password
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}

/// Widget untuk input email dan password
Widget inputField(BuildContext context, TextEditingController emailController, TextEditingController passwordController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Email",
            hintStyle: const TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.email_rounded, color: Theme.of(context).primaryColor),
          ),
          style: TextStyle(color: Theme.of(context).primaryColor),
          keyboardType: TextInputType.emailAddress,
        ),
      ),
      const SizedBox(height: 20),
      PasswordField(
        controller: passwordController,
        hintText: "Password",
      ),
    ],
  );
}

/// Widget untuk tombol login
Widget loginButton(BuildContext context, TextEditingController emailController, TextEditingController passwordController, String validEmail, String validPassword) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width * 0.8,
      minHeight: 50,
    ),
    child: ElevatedButton(
      onPressed: () {
        if (emailController.text == validEmail && passwordController.text == validPassword) {
          Fluttertoast.showToast(
            msg: "Berhasil Login",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Invalid Email or Password',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        backgroundColor: Colors.lightGreenAccent,
      ),
      child: const Text(
        "LOGIN",
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

/// Widget untuk tombol autentikasi sidik jari
Widget fingerprintButton(BuildContext context) {
  final AuthService authService = AuthService();

  return ElevatedButton(
    onPressed: () async {
      bool isAuthenticated = await authService.authenticateWithBiometrics();
      if (isAuthenticated) {
        Fluttertoast.showToast(
          msg: "Berhasil Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Authentication Failed',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    },
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(10),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    child: const Icon(Icons.fingerprint, size: 50),
  );
}

/// Widget untuk kombinasi login dan autentikasi
Widget loginAuth(BuildContext context, TextEditingController emailController, TextEditingController passwordController, String validEmail, String validPassword) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      inputField(context, emailController, passwordController),
      const SizedBox(height: 20),
      loginButton(context, emailController, passwordController, validEmail, validPassword),
      const SizedBox(height: 10),
      fingerprintButton(context),
    ],
  );
}

/// Widget untuk navigasi ke halaman pendaftaran
Widget signUp(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Belum punya akun?"),
      TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SignUpPage()),
          );
        },
        child: const Text(
          "Daftar",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
