import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@immutable
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Image.asset(
      'assets/img/logo.png',
      scale: 2,
    )).animate().fadeIn().scaleXY(begin: .7, end: 1));
  }
}
