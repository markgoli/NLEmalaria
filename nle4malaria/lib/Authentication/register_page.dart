import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nle4malaria/Authentication/components/my_button.dart';
import 'package:nle4malaria/Authentication/components/my_textfield.dart';
import 'package:nle4malaria/Authentication/components/my_textfield1.dart';
import 'package:nle4malaria/Authentication/components/square_tile.dart';
import 'package:nle4malaria/Services/authservice.dart';
import 'package:nle4malaria/styles/color.dart';
import 'package:nle4malaria/styles/theme.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  //Text Editing Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  //Sign UserUp Method
  void signUserUp() async {
    //print('Attempting to sign up...'); // Debug print

    // Check if email is in valid format
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      // Show dialog for invalid email format
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid Email Format'),
            content: const Text('Please enter a valid email address.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Check if passwords match
    if (passwordController.text != confirmpasswordController.text) {
      // Show dialog for password mismatch
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Passwords Do Not Match'),
            content: const Text('Please make sure the passwords match.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // Try sign up
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Close loading dialog
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // print('Error: $e');
      // Close loading dialog
      // Navigator.pop(context);
      // Check if email already exists
      if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Email Already in Use'),
              content: const Text('The provided email is already registered.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

//Password match message
//wrong email pop
  void passwordMatchMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              title: Text('Incorrect Email'),
              content: Text('No user found for that email.'));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2Color,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                //welcome Text
                const SizedBox(
                    child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: mainBlue,
                  ),
                )),
                const SizedBox(
                  height: 30,
                ),

                //logo
                Image.asset(
                  'assets/images/microscope.png',
                  height: 80,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Create your account here.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: (mainBlue),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //email text box
                MyTextField(
                  controller: emailController,
                  hintText: 'Your Email',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 20,
                ),
                //Password text box
                MyTextField1(
                  controller: passwordController,
                  hintText: 'Enter password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                //Confirm Password text box
                MyTextField1(
                  controller: confirmpasswordController,
                  hintText: 'Confirm password',
                  obscureText: true,
                ),
                //forgot password
                const SizedBox(
                  height: 10,
                ),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'Forgot Password?',
                //         style: TextStyle(
                //             color: (Color(0xFF063509)),
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 10),

                //login button
                MyButton(
                  onTap: signUserUp,
                  text: 'SignUp',
                ),
                const SizedBox(
                  height: 20,
                ),

                //continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Or continue with',
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //google + apple signin buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google

                    SquareTile(
                      imagePath: 'assets/images/google.png',
                      onTap: () => AuthService().signInWithGoogle(),
                    ),
                    //Apple
                    const SizedBox(
                      width: 40,
                    ),
                    SquareTile(
                      onTap: () {},
                      imagePath: 'assets/images/apple.png',
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Text('Already have an account?'),
                    // const SizedBox(
                    //   width: 10,
                    // ),

                    // GestureDetector(
                    //   onTap: widget.onTap,
                    //   child: const Text(
                    //     'Login now',
                    //     style: TextStyle(
                    //         color: (Color(0xFF063509)),
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),

                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account? ",
                            style: AppTheme.titleStyle2(isBold: true),
                          ),
                          TextSpan(
                            text: "Login Now",
                            style: AppTheme.titleStyle(
                                color: mainBlue, isBold: true),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/login_screen');
                              },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
