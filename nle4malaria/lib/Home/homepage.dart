// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nle4malaria/Home/Cards.dart';
import 'package:nle4malaria/Home/Cards2.dart';
import 'package:nle4malaria/plasmodium/uploadImage.dart';
import 'package:nle4malaria/plasmodium/common_plasmodium_types.dart';
// import 'package:nle4malaria/Home/video.dart';
import 'package:nle4malaria/config/extensions.dart';
import 'package:nle4malaria/plasmodium/video.dart';
import 'package:nle4malaria/styles/color.dart';
import 'package:nle4malaria/styles/theme.dart';
// import 'package:nle4malaria/Authentication/common_diseases.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // Sign out user method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    // Handle navigation to different pages based on index
    // For simplicity, let's just update the index here
    _selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainAppColor,
        title: Center(
          child: Text(
            'Hi, ${user.email!}',
            style: AppTheme.titleStyle(color: Blue, isBold: true),
          ),
        ),
        actions: [
          IconButton(
              onPressed: signUserOut,
              icon: Padding(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.logout,
                  color: mainBlue,
                ),
              ))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: bg2Color),
        child: Center(
          child: Column(
            children: [
              10.height(),
              Image.asset(
                'assets/images/microscope.png',
                height: 50,
                width: 50,
              ),
              Text(
                'Malaria Microscopy',
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 15,
                    color: mainBlue,
                    fontWeight: FontWeight.bold),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  viewportFraction: 0.8,
                ),
                items: [
                  'assets/images/front.png',
                  'assets/images/setup.png',
                  'assets/images/stages.jpg',
                  'assets/images/falcipalam.jpeg',
                  'assets/images/plasm_types2.jpeg',
                  'assets/images/distribution.jpg',
                  'assets/images/mosquito.webp',
                ].map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // color: Colors.amber,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(imagePath, fit: BoxFit.fitWidth),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                width: 300,
                height: 250,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: mainAppColor),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                        'Menu',
                        style: TextStyle(
                            color: mainBlue,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                            fontSize: 20),
                      )),
                      10.height(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MySecCard(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UploadImage()));
                            },
                            text: 'Diagnose',
                            path: 'assets/images/side.png',
                          ),
                          40.width(),
                          MyCard(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PlasmodiumParasiteChecker()));
                              },
                              text: 'Plasmodium types',
                              icon: Icon(Icons.bug_report)),
                        ],
                      ),
                      10.height(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyCard(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PlasmodiumParasiteChecker()));
                              },
                              text: 'Dataset',
                              icon: Icon(Icons.dataset)),
                          20.width(),
                          MyCard(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoPage()));
                              },
                              text: 'Want to Learn more?',
                              icon: Icon(Icons.video_file_rounded)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: lightBlue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services_sharp),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: mainBlue,
        unselectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Column homepageicons(
//   IconData icons,
//   String action,
// ) {
//   return Column(
//     children: [
//       Container(
//         height: 60,
//         width: 60,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15), color: cream),
//         child: Center(
//           child: IconButton(
//             color: mainBlue,
//             iconSize: 30,
//             onPressed: () {
//               //todo: action
//             },
//             icon: Icon(icons),
//           ),
//         ),
//       ),
//       const SizedBox(
//         height: 5,
//       ),
//       Text(
//         action,
//         style: const TextStyle(
//             color: black, fontWeight: FontWeight.w400, fontSize: 15),
//       ),
//     ],
//   );
// }
