import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nle4malaria/Authentication/login_or_register.dart';
import 'package:nle4malaria/Home/homepage2.dart';
//import 'package:nle4malaria/Authentication/login_page.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           //user logged in

//           if (snapshot.hasData) {
//             return MyHomePage2();
//           }
//           //user not logged in
//           else {
//             return const LoginOrRegisterPage();
//           }
//         },
//       ),
//     );
//   }
// }

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User logged in
          if (snapshot.hasData) {
            return MyHomePage2();
          }
          // User not logged in
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
