import 'package:flutter/material.dart';
import 'dart:async';
import '../screens/auth/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _circleSize = 100;
  bool _isExpanded = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _circleSize = MediaQuery.of(context).size.height * 1.5;
          _isExpanded = true;
        });
      }
    });

    _timer = Timer(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Pastikan timer dibersihkan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 2),
            width: _circleSize,
            height: _circleSize,
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              shape: BoxShape.circle,
            ),
          ),
          Positioned(
            child: Image.asset(
              _isExpanded ? 'assets/higertech.png' : 'assets/hgt.png',
              width: 120,
            ),
          ),
        ],
      ),
    );
  }
}
