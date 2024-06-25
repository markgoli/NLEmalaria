import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nle4malaria/components/my_button.dart';
import 'package:nle4malaria/components/my_textfield.dart';
import 'package:nle4malaria/components/my_textfield1.dart';
import 'package:nle4malaria/components/square_tile.dart';
import 'package:nle4malaria/Authentication/forgot_password.dart';
import 'package:nle4malaria/Services/authservice.dart';
import 'package:nle4malaria/styles/color.dart';
import 'package:nle4malaria/styles/theme.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text Editing Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Sign UserIn Method
  void signUserIn() async {
    print('Attempting to sign in...'); // Debug print
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    //try signin
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // print('FirebaseAuthException occurred: ${e.code}'); // Debug print
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        //  print('No user found for that email.');
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        wrongPasswordMessage();
      } else if (e.code == 'invalid-credential') {
        // print(
        //     'The supplied auth credential is incorrect, malformed or has expired.');
        wrongCredentialMessage();
      } else if (e.code == 'user-disabled') {
        //print('The user account has been disabled by an administrator.');
        userDisabledMessage();
      } else if (e.code == 'invalid-email') {
        // print('The email is badly formatted');
        wrongEmailMessage1();
      } else {
        // print('Unhandled error occurred: ${e.message}');
      }
    }
  }

//wrong email pop
  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              title: Text('Incorrect Email'),
              content: Text('No user found for that email.'));
        });
  }

  //Wrong password popup
  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect Password'),
            content: Text('Wrong password provided for that user.'),
          );
        });
  }

  //wrong credentials
  void wrongCredentialMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              title: Text('Invalid credentials'),
              content: Text('The supplied auth credentials are incorrect'));
        });
  }

  //Disabled user
  void userDisabledMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              title: Text('User disabled'),
              content: Text('The owner of this account is disabled'));
        });
  }

  //wrong email pop
  void wrongEmailMessage1() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              title: Text('Incorrect Email'),
              content: Text('The email is badly formatted'));
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
                  height: 50,
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
                //forgot password
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //forgot password
                      GestureDetector(
                        onTap: () {
                          // Navigate to the ForgotPasswordScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: (mainBlue), fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                //login button
                MyButton(
                  onTap: signUserIn,
                  text: 'LOGIN',
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
                  height: 20,
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
                  height: 20,
                ),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: AppTheme.titleStyle2(isBold: true),
                          ),
                          TextSpan(
                            text: "SignUp.",
                            style: AppTheme.titleStyle(
                                color: mainBlue, isBold: true),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/register_page');
                              },
                          )
                        ],
                      ),
                    ),
                    // const Text('Not a member?'),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // GestureDetector(
                    //   onTap: widget.onTap,
                    //   child: const Text(
                    //     'Register now',
                    //     style: TextStyle(
                    //         color: (Color(0xFF063509)),
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
