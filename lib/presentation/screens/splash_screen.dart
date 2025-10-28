import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'auth/login_screen.dart'; // We'll navigate to Login first
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart'; // Import animate_do

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    // Wait for animations to feel complete
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 1. Gradient Background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 2. Animated Lottie File
              FadeInDown(
                duration: const Duration(milliseconds: 1200),
                child: Lottie.asset(
                  'lib/assets/pet_animation.json', // Corrected asset path
                  width: 300,
                  height: 300,
                  // Add a fallback in case the asset fails to load
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.pets,
                      size: 300,
                      color: Colors.white.withOpacity(0.5),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // 2. Animated Title
              FadeInUp(
                duration: const Duration(milliseconds: 1500),
                child: Text(
                  'PetPals',
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Animated Tagline
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 1500),
                child: Text(
                  'Find your new best friend',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

