import 'package:flutter/material.dart';

class AnimatedPageRoute extends PageRouteBuilder {
  final Widget page;

  AnimatedPageRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
        body: page, // Hanya body dari halaman yang akan dipindahkan
      );
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const offsetBegin = Offset(1.0, 0.0); // Mengatur offset awal animasi
      const offsetEnd = Offset.zero; // Mengatur offset akhir animasi
      const curve = Curves.easeInOut;

      var tween = Tween<Offset>(begin: offsetBegin, end: offsetEnd).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

// Kelas Route tanpa animasi
class NoAnimationPageRoute extends PageRouteBuilder {
  final Widget page;

  NoAnimationPageRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration.zero, // Tidak ada durasi transisi
    reverseTransitionDuration: Duration.zero, // Tidak ada durasi transisi saat mundur
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child; // Tidak ada animasi transisi
    },
  );
}
