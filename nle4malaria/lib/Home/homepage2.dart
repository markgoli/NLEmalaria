import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nle4malaria/Home/homecards.dart';
import 'package:nle4malaria/config/extensions.dart';
import 'package:nle4malaria/styles/color.dart';

class MyHomePage2 extends StatelessWidget {
  // user instance
  final user = FirebaseAuth.instance.currentUser!;
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
            backgroundColor: bg2Color,
            centerTitle: false,
            expandedHeight: 180.0, // Height when fully expanded
            floating: false,
            pinned: true, // AppBar stays at top but expands when scrolling
            flexibleSpace: FlexibleSpaceBar(
              title: Text('MicroMalaria Insights',
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: mainAppColor2)),
              background: Stack(children: [
                Image.asset(
                  'assets/images/silver.webp', // Replace with your actual image URL or asset
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  color: white.withOpacity(0.5),
                )
              ]),
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
                  height: 25,
                  width: 25,
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
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: white),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(20),
                              // color: redColor,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    width: 100,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        'assets/images/doctor_1.jpg',
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Hi, ${user.displayName}!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(color: mainBlue),
                                      ),
                                      10.height(),
                                      Container(
                                        // color: redColor,
                                        margin: EdgeInsets.only(left: 10),
                                        width: 180,
                                        height: 100,
                                        child: Text(
                                          'Become the best Microscopist in the World as you leverage the power of Artifial Intelligence in MALARIA MICROSCOPY. This tool offers Fast and Quick Detection of Malaria plasmodium parasites. Try out the analysis tools below.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: mainAppColor),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // 5.height(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Analysis Tools',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: mainAppColor2),
                                )
                              ],
                            ),
                            10.height(),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: MenuContainer(),
                            ),

                            // 5.height(),
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
                                // 'assets/images/setup.png',
                                'assets/images/person.webp',
                                'assets/images/real.webp',
                                'assets/images/micro.webp',
                                'assets/images/mosquito.webp',
                              ].map((imagePath) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
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
                            // Padding(
                            //   padding: const EdgeInsets.all(10.0),
                            //   child: MenuContainer(),
                            // ),
                            // Container(
                            //   width: 300,
                            //   height: 230,
                            //   margin: EdgeInsets.all(10),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(12),
                            //       image: DecorationImage(
                            //           image: AssetImage(
                            //               'assets/images/person.webp'),
                            //           fit: BoxFit.cover),
                            //       color: mainAppColor),
                            //   child: Stack(children: [
                            //     Container(
                            //       width: double.infinity,
                            //       height: double.infinity,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(12),
                            //         color: mainAppColor.withOpacity(0.85),
                            //       ),
                            //       child: Column(
                            //         children: [
                            //           Center(
                            //               child: Text(
                            //             'Menu',
                            //             style: TextStyle(
                            //                 color: white,
                            //                 fontWeight: FontWeight.bold,
                            //                 fontFamily: 'Roboto',
                            //                 fontSize: 20),
                            //           )),
                            //           10.height(),
                            //           Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.center,
                            //             children: [
                            //               MySecCard(
                            //                 onTap: () {
                            //                   Navigator.push(
                            //                       context,
                            //                       MaterialPageRoute(
                            //                           builder: (context) =>
                            //                               const UploadImage()));
                            //                 },
                            //                 text: 'Diagnose',
                            //                 path: 'assets/images/side.png',
                            //               ),
                            //               40.width(),
                            //               MyCard(
                            //                   onTap: () {
                            //                     Navigator.push(
                            //                         context,
                            //                         MaterialPageRoute(
                            //                             builder: (context) =>
                            //                                 const PlasmodiumParasiteChecker()));
                            //                   },
                            //                   text: 'Sensitization',
                            //                   icon: Icon(Icons.bug_report)),
                            //             ],
                            //           ),
                            //           10.height(),
                            //           Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.center,
                            //             children: [
                            //               MyCard(
                            //                   onTap: () {
                            //                     Navigator.push(
                            //                         context,
                            //                         MaterialPageRoute(
                            //                             builder: (context) =>
                            //                                 DatasetGalleryScreen()));
                            //                   },
                            //                   text: 'Dataset',
                            //                   icon: Icon(Icons.dataset)),
                            //               20.width(),
                            //               MyCard(
                            //                   onTap: () {
                            //                     Navigator.push(
                            //                         context,
                            //                         MaterialPageRoute(
                            //                             builder: (context) =>
                            //                                 VideoPage()));
                            //                   },
                            //                   text: 'Want to Learn more?',
                            //                   icon: Icon(
                            //                       Icons.video_file_rounded)),
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ]),
                            // ),
                          ],
                        ),
                      ),
                    ],
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
