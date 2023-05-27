import 'dart:async';

import 'package:firebase_app/firebase_auth/login_screen.dart';
import 'package:firebase_app/main_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(
            seconds: 5,
          ), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ));
      });
    } else {
      Timer(
          const Duration(
            seconds: 5,
          ), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
      });
    }
  }
}

class Utils {
  void toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
    backgroundColor:
    Colors.red;
    fontSize:
    15.8;
  }
}
