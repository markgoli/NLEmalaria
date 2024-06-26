import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nle4malaria/components/Cards.dart';
import 'package:nle4malaria/components/Cards2.dart';
import 'package:nle4malaria/config/extensions.dart';
import 'package:nle4malaria/plasmodium/Dataset.dart';
import 'package:nle4malaria/plasmodium/common_plasmodium_types.dart';
import 'package:nle4malaria/plasmodium/uploadImage.dart';
import 'package:nle4malaria/plasmodium/video.dart';
import 'package:nle4malaria/styles/color.dart';

class MyHomePage2 extends StatelessWidget {
  // Sign out user method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            expandedHeight: 200.0, // Height when fully expanded
            floating: false,
            pinned: true, // AppBar stays at top but expands when scrolling
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '\n\nMicroMalaria Insights',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: mainAppColor2,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              background: Image.asset(
                'assets/images/micro.webp', // Replace with your actual image URL or asset
                fit: BoxFit.cover,
              ),
              centerTitle: true,
              titlePadding: EdgeInsets.only(right: 20, top: 0),
            ),
            leading: IconButton(
              color: mainAppColor2,
              icon: Icon(
                  Icons.menu), // Leading icon, e.g., for a menu or back button
              onPressed: () {
                // Handle icon button press
              },
            ),
            actions: <Widget>[
              IconButton(
                color: mainAppColor2,
                icon: Icon(Icons
                    .notifications_none_outlined), // Another action icon for notifications
                onPressed: () {
                  // Handle notifications icon press
                },
              ),
              IconButton(
                color: mainAppColor2,
                icon: Image.asset(
                  'assets/images/logout.png',
                  height: 30,
                  width: 30,
                ),
                onPressed: () {
                  signUserOut();
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(color: bg2Color),
                  child: Center(
                    child: Column(
                      children: [
                        // 10.height(),
                        // Image.asset(
                        //   'assets/images/microscope.png',
                        //   height: 50,
                        //   width: 50,
                        // ),
                        // Text(
                        //   'Malaria Microscopy',
                        //   style: TextStyle(
                        //       fontFamily: 'roboto',
                        //       fontSize: 15,
                        //       color: mainBlue,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: white),
                          child: Column(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 290,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 1000),
                                  viewportFraction: 1,
                                ),
                                items: [
                                  'assets/images/black.webp',
                                  'assets/images/real.webp',
                                  'assets/images/front.png',
                                  'assets/images/setup.png',
                                  'assets/images/person.webp',
                                  'assets/images/real.webp',
                                  'assets/images/silver.webp',
                                  'assets/images/mosquito.webp',
                                ].map((imagePath) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          // color: Colors.amber,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Image.asset(imagePath,
                                              fit: BoxFit.fitWidth),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                              Container(
                                width: 300,
                                height: 230,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/person.webp'),
                                        fit: BoxFit.cover),
                                    color: mainAppColor),
                                child: Stack(children: [
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: mainAppColor.withOpacity(0.85),
                                    ),
                                    child: Column(
                                      children: [
                                        Center(
                                            child: Text(
                                          'Menu',
                                          style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto',
                                              fontSize: 20),
                                        )),
                                        10.height(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                text: 'Sensitization',
                                                icon: Icon(Icons.bug_report)),
                                          ],
                                        ),
                                        10.height(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            MyCard(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DatasetGalleryScreen()));
                                                },
                                                text: 'Dataset',
                                                icon: Icon(Icons.dataset)),
                                            20.width(),
                                            MyCard(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              VideoPage()));
                                                },
                                                text: 'Want to Learn more?',
                                                icon: Icon(
                                                    Icons.video_file_rounded)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 1, // Number of containers in the list
            ),
          ),
        ],
      ),
    );
  }
}
