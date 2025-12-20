import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scale = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();

    // ⏱️ Tempo da splash
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/roles');
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
      backgroundColor: const Color(0xFFFFF3E0), // fundo alegre
      body: Center(
        child: ScaleTransition(
          scale: _scale,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 260,
              ),
              const SizedBox(height: 24),
              const Text(
                'Aprender brincando é mais divertido!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


