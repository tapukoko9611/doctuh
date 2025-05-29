import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async'; // Required for Timer

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Start a timer to navigate after a few seconds
    Timer(const Duration(seconds: 3), () {
      // Navigate to the AuthWrapper which handles login state
      Get.offAllNamed('/auth_wrapper');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Or any color that matches your splash design
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your splash image
            Image.asset(
              'assets/doctor.png', // <--- Use your splash image path
              width: 150, // Adjust size as needed
              height: 150, // Adjust size as needed
            ),
            const SizedBox(height: 20),
            // Your headline text
            const Text(
              'Your Doctor',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your Health, Our Priority', // Tagline or subtitle
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}