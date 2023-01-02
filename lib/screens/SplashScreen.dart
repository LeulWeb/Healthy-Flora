import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:healthy_flora/screens/Home.dart';

class SplashScreen extends StatefulWidget {
  // const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/splash.png'),
      splashIconSize: 300,
      nextScreen: Home(),
      duration: 3000,
      backgroundColor: Colors.white,
      centered: true,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
