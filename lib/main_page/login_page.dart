import 'package:flutter/material.dart';
import '../main_page_function/login_function.dart';

/// Halaman login yang menggunakan autentikasi email/password dan biometrik.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String validEmail = 'user@user.com';
  final String validPassword = '123';

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
                    // Login Auth
                    Container(
                      margin: EdgeInsets.only(bottom: paddingBottom),
                      child: loginAuth(context, emailController, passwordController, validEmail, validPassword),
                    ),
                    // Sign Up
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: signUp(context),
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
