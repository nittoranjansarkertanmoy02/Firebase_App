// ignore_for_file: prefer_const_constructors

import 'package:firebase_app/functions/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    letterSpacing: 1.8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                auth
                    .sendPasswordResetEmail(
                        email: emailController.text.toString())
                    .then((value) {
                  Utils().toastMessage('Please Check email');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'Forgot',
                    style: TextStyle(
                      letterSpacing: 1.8,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
