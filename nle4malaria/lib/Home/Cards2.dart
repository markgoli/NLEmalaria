import 'package:flutter/material.dart';
import 'package:nle4malaria/styles/color.dart';

class MySecCard extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final String path;
  final Image? image;
  const MySecCard(
      {super.key,
      required this.onTap,
      required this.text,
      this.image,
      required this.path});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: mainBlue),
          child: Center(
            child: IconButton(
              color: white,
              iconSize: 50,
              onPressed: onTap,
              icon: Image.asset(path),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: const TextStyle(
              color: mainBlue, fontWeight: FontWeight.w400, fontSize: 12),
        ),
      ],
    );
  }
}
