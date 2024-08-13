import 'package:flutter/material.dart';
import '../main_page/login_page.dart';

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

Widget inputFields(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    bool showPassword,
    bool showConfirmPassword,
    VoidCallback togglePasswordVisibility,
    VoidCallback toggleConfirmPasswordVisibility
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // Email TextField
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
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
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

      // Password TextField
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
          controller: passwordController,
          obscureText: !showPassword,
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
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
                showPassword ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: togglePasswordVisibility,
            ),
          ),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      const SizedBox(height: 20),

      // Confirm Password TextField
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
          controller: confirmPasswordController,
          obscureText: !showConfirmPassword,
          decoration: InputDecoration(
            hintText: "Konfirmasi Password",
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
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
                showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: toggleConfirmPasswordVisibility,
            ),
          ),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    ],
  );
}

Widget signUpButton(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    void Function() onRegisterPressed,
    ) {
  return ElevatedButton(
    onPressed: onRegisterPressed, // Hanya panggil onRegisterPressed tanpa navigasi langsung
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.green, // Warna teks tombol
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: const Text(
      'Daftar',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
  );
}

Widget signIn(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Sudah punya akun?"),
      TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
        child: const Text(
          "Masuk",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
