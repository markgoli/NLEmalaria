// import 'package:lmloan/config/constants.dart';
// import 'package:lmloan/styles/color.dart';
// import 'package:lmloan/styles/theme.dart';
import 'dart:async';

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

    // Scaffold(
    //   backgroundColor: mainAppColor,
    //   body: SingleChildScrollView(
    //     child: Container(
    //       width: screensize.width,
    //       height: screensize.height,
    //       child: Stack(
    //         children: [
    //           Image.asset(
    //             'assets/images/setup.png',
    //             width: screensize.width,
    //             height: screensize.height,
    //             // width: 370,
    //             // height: 600,
    //             fit: BoxFit.cover,
    //           ),
    //           Center(
    //             child: Column(
    //               children: [
    //                 620.height(),
    //                 Text(
    //                   'Malaria',
    //                   style: AppTheme.splashScreenStyle(
    //                       color: whiteColor, isBold: true),
    //                 ),
    //                 Text(
    //                   'Microscopy',
    //                   style: AppTheme.splashScreenStyle(
    //                       color: whiteColor, isBold: true),
    //                 ),
    //                 Text(
    //                   'with',
    //                   style: AppTheme.subTitleStyle(
    //                       color: greyColor, isBold: true),
    //                 ),
    //                 Text(
    //                   'Natural Language Explanations',
    //                   style:
    //                       AppTheme.subTitleStyle(color: mainBlue, isBold: true),
    //                 ),
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
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

// class SplashScreenMain extends StatefulWidget {
//   @override
//   _SplashScreenMainState createState() => _SplashScreenMainState();
// }

// class _SplashScreenMainState extends State<SplashScreenMain> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//       Duration(seconds: 3),
//       () => Navigator.of(context)
//           .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen())),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(
//               'assets/images/splashScreen.webp'), // Make sure to add your image in the assets folder
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }
