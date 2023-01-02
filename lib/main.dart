// ignore_for_file: prefer_const_constructor
import 'package:flutter/material.dart';
import 'package:healthy_flora/screens/SplashScreen.dart';

void main() {
  runApp(MaterialApp(
    title: "Healthy Flora",
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(),
    );
  }
}
