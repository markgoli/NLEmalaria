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
import 'package:nle4malaria/config/extensions.dart';
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
                Container(
                  height: 270,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      image: DecorationImage(
                          image: AssetImage('assets/images/register2.webp'),
                          fit: BoxFit.cover)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //welcome Text
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 50, right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.2)),
                        child: Center(
                          child: const SizedBox(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Login Here',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: white,
                              ),
                            ),
                          )),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),

                      //logo
                      Container(
                          margin: EdgeInsets.all(5),
                          height: 210,
                          width: 190,
                          decoration: BoxDecoration(
                              color: white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Join us on a journey of scientific discovery and innovation. Whether you're a healthcare professional, researcher, or student, MicroMalaria Insights offers a unique educational tool that enhances your understanding of one of the world's most significant infectious diseases.",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: mainAppColor2,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                30.height(),
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
                                color: primaryColor, isBold: true),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/register_page');
                              },
                          )
                        ],
                      ),
                    ),
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
