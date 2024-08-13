import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../main_page/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late int _repeatCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _repeatCount = Random().nextInt(1) + 1;
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_repeatCount > 1) {
          _repeatCount--;
          _controller.forward(from: 0.0);
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Lottie.asset(
                  "assets/animation/Loading Animation v2.json",
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
