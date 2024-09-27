import 'package:flutter/material.dart';
import 'dart:async';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:showtime/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Start a timer to navigate to the HomeScreen after 2 seconds
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      backgroundColor: Colors.black,
      splashScreenBody: Center(
        child: Image.asset(
          "assets/images/SHOWTIME-27-9-2024.gif",
          width: 300,
          height: 200,
        ),
      ),
      duration: const Duration(seconds: 2), // Optional: This is just for splash screen appearance
    );
  }
}
