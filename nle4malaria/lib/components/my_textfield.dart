import 'package:flutter/material.dart';
import 'package:nle4malaria/styles/color.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final obscureText;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
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
            fillColor: bgColor,
            filled: true,
            hintText: hintText),
      ),
    );
  }
}
