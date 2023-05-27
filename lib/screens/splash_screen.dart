import 'package:firebase_app/functions/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splash = SplashServices();
  @override
  void initState() {
    super.initState();
    splash.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome",
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 1.8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
