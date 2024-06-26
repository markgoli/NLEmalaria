import 'package:flutter/material.dart';
import 'package:nle4malaria/styles/color.dart';

class MyCard extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Icon icon;
  final Image? image;
  const MyCard(
      {super.key,
      required this.onTap,
      required this.text,
      required this.icon,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: mainAppColor2, // Color of the border
              width: 1, // Width of the border
            ),
            color: mainAppColor2.withOpacity(0.4),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: IconButton(
                color: white,
                iconSize: 50,
                onPressed: onTap,
                icon: icon,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: const TextStyle(
              color: white, fontWeight: FontWeight.w400, fontSize: 12),
        ),
      ],
    );
  }
}
