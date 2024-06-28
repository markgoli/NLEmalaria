// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nle4malaria/components/Buttons.dart';
import 'package:nle4malaria/config/extensions.dart';
import 'package:nle4malaria/plasmodium/uploadImage.dart';
import 'package:nle4malaria/styles/color.dart';

class Results extends StatelessWidget {
  final File? image;
  String label;
  String caption;

  Results(
      {Key? key,
      required this.image,
      required this.label,
      required this.caption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Diagnostic Report',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: mainBlue),
        ),
        centerTitle: true,
        elevation: 4.0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Padding(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.translate,
                  color: white,
                ),
              ))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: lightBlue,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.2),
          //     spreadRadius: 2,
          //     blurRadius: 8,
          //     offset: const Offset(2, 2),
          //   ),
          // ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: lightBlue,
                borderRadius: BorderRadius.circular(4),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.2),
                //     spreadRadius: 2,
                //     blurRadius: 8,
                //     offset: const Offset(2, 2),
                //   ),
                // ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: grey2,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        image!,
                        // width: 34,
                        // height: 34,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Classified as: ',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: mainBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                          // decoration: TextDecoration.underline,
                          decorationColor: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: greenColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                          // decoration: TextDecoration.underline,
                          decorationColor: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  30.height(),
                  Card(
                    color: lightcyan,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text(
                        caption,
                        // 'There are 19 pathogens observed from the eyepeice, which belong to P-Falciparum Class of Malaria Plasmodia.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: mainBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                          // decoration: TextDecoration.underline,
                          decorationColor: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  80.height(),
                  UploadButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UploadImage()),
                      );
                    },
                    text: 'Scan Again',
                    icon: Icon(
                      Icons.camera_sharp,
                      color: white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
