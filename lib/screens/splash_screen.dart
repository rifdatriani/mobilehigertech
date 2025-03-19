import 'package:flutter/material.dart';
import 'dart:async';
import '../screens/auth/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _circleSize = 100;
  final double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startSplashSequence();
  }

  void _startSplashSequence() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _circleSize = 1.0;
      });
    });

     Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _circleSize = MediaQuery.of(context).size.shortestSide * 2;
      });
    });
  }

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // SplashScreen 2: Logo memudar dan berubah
          AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: _opacity,
            child: Container(
              color: Colors.blue[900],
              child: Center(child: Image.asset('assets/hgt.png', width: 120)),
            ),
          ),
          
          // SplashScreen 1: Lingkaran membesar
          AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            width: _circleSize,
            height: _circleSize,
            decoration: BoxDecoration(
              color: Colors.blue[900],
              shape: BoxShape.circle,
            ),
          ),
          Center(child: Image.asset('assets/higertech.png', width: 200)),
        ],
      ),
    );
  }
}
