import 'package:firebase_app/forgot_password.dart';
import 'package:firebase_app/main_home.dart';
import 'package:firebase_app/firebase_auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _keyForm,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Password'),
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            InkWell(
                onTap: () {
                  if (_keyForm.currentState!.validate()) {
                    _auth.signInWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString());

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ));
                  }
                },
                child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    child: const Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                        letterSpacing: 1.8,
                      ),
                    )))),
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ));
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ));
              },
              child: const Text("Don't Have an account? Signup"),
            ),
          ],
        ),
      ),
    );
  }
}
