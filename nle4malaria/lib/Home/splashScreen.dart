// import 'package:lmloan/config/constants.dart';
// import 'package:lmloan/styles/color.dart';
// import 'package:lmloan/styles/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nle4malaria/config/extensions.dart';
import 'package:nle4malaria/styles/color.dart';
import 'package:nle4malaria/styles/theme.dart';

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
    final Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 18, 90),
      body: SingleChildScrollView(
        child: Container(
          width: screensize.width,
          height: screensize.height,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/splach.jpg',
                width: screensize.width,
                height: screensize.height,
                fit: BoxFit.cover,
              ),
              Center(
                child: Column(
                  children: [
                    560.height(),
                    Text(
                      'Malaria',
                      style: AppTheme.splashScreenStyle(
                          color: whiteColor, isBold: true),
                    ),
                    Text(
                      'Microscopy',
                      style: AppTheme.splashScreenStyle(
                          color: whiteColor, isBold: true),
                    ),
                    Text(
                      'with',
                      style: AppTheme.subTitleStyle(
                          color: greyColor, isBold: true),
                    ),
                    Text(
                      'Natural Language Explanations',
                      style: AppTheme.subTitleStyle(
                          color: primaryColor, isBold: true),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Stack(
      //         children: [
      //           Image(image: AssetImage('assets/images/splach.jpg')),
      //           Center(
      //             child: Text(
      //               'Malaria Microscopy',
      //               style:
      //                   TextStyle(backgroundColor: Colors.white, fontSize: 30),
      //             ),
      //           )
      //         ],
      //       )
      //       // const SizedBox(
      //       //     width: 300,
      //       //     height: 300,
      //       //     child: Image(image: AssetImage('assets/images/icon.webp'))),

      //       // Text(
      //       //   'Malaria',
      //       //   // style: AppTheme.splashScreenStyle(color: whiteColor),
      //       // ),
      //       // Text(
      //       //   'For a Better Life!.',
      //       //   // style: AppTheme.titleStyle(color: primaryColor),
      //       // )
      //     ],
      //   ),
      // ),
    );
  }

  void _navigate() {
    Future.delayed(const Duration(seconds: 10), () {
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
