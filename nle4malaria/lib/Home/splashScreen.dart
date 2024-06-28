// import 'package:lmloan/config/constants.dart';
// import 'package:lmloan/styles/color.dart';
// import 'package:lmloan/styles/theme.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    // final Size screensize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/splashScreen.webp'), // Make sure to add your image in the assets folder
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      // return AuthPage();
      if (FirebaseAuth.instance.currentUser != null) {
        context.go('/homepage');
        // return AuthPage();
      } else {
        context.go('/register_page');
        // return LoginOrRegisterPage();
      }
    });
  }
}
