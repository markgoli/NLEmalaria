import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nle4malaria/Authentication/components/my_button.dart';
import 'package:nle4malaria/styles/color.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  void _resetPassword(BuildContext context) async {
    String email = emailController.text.trim();
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // Show success message and navigate to login page
        _showSuccessMessage(context);
      } catch (e) {
        // Handle specific errors like 'user-not-found'
        if (e.hashCode == 'user-not-found') {
          // Show error message indicating email doesn't exist
        } else {
          // Show generic error message
          print("Failed to send password reset email: $e");
        }
      }
    } else {
      // Show error message for empty email
    }
  }

  void _showSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Password Reset Email Sent"),
          content:
              const Text("A password reset link has been sent to your email."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context)
                    .pop(); // Pop the current screen (Forgot Password Screen)
              },
              child: const Text("Okay"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 25.0),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 25.0),
              const Text(
                'Forgot Password?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, color: mainBlue),
              ),
              const SizedBox(height: 25.0),
              const Text(
                'Enter your email and we will send you a password reset link.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (Color(0xFF063509)),
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter your email'),
                ),
              ),
              const SizedBox(height: 25.0),
              MyButton(
                onTap: () => _resetPassword(context),
                text: ('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
