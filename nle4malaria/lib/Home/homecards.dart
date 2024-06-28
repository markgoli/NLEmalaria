// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nle4malaria/plasmodium/Dataset.dart';
import 'package:nle4malaria/plasmodium/common_plasmodium_types.dart';
import 'package:nle4malaria/plasmodium/uploadImage.dart';
import 'package:nle4malaria/plasmodium/video.dart';
import 'package:nle4malaria/styles/color.dart';

class MenuContainer extends StatelessWidget {
  const MenuContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomIcon> customIcons = [
      CustomIcon(name: "Diagnose", icon: 'assets/images/side.png'),
      CustomIcon(name: "Sensitization", icon: 'assets/images/hospital.png'),
      CustomIcon(name: "Dataset", icon: 'assets/images/virus.png'),
      CustomIcon(name: "More", icon: 'assets/images/more.png'),
    ];
    List<CustomIcon> healthNeeds = [
      CustomIcon(name: "Tutorial", icon: 'assets/images/appointment.png'),
      CustomIcon(name: "Hospital", icon: 'assets/images/hospital.png'),
      CustomIcon(name: "Covid-19", icon: 'assets/images/virus.png'),
      CustomIcon(name: "Pharmacy", icon: 'assets/images/drug.png'),
    ];
    List<CustomIcon> specialisedCared = [
      CustomIcon(name: "Diabetes", icon: 'assets/images/blood.png'),
      CustomIcon(name: "Health Care", icon: 'assets/images/health_care.png'),
      CustomIcon(name: "Dental", icon: 'assets/images/tooth.png'),
      CustomIcon(name: "Insured", icon: 'assets/images/insurance.png'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(customIcons.length, (index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                if (index == customIcons.length - 1) {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        height: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // HEALTH NEEDS SECTION
                            Text(
                              "Health Needs",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                healthNeeds.length,
                                (index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (index == healthNeeds.length - 4) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VideoPage()));
                                          }
                                        },
                                        borderRadius: BorderRadius.circular(90),
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer
                                                .withOpacity(0.4),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            healthNeeds[index].icon,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(healthNeeds[index].name)
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 30),
                            // SPECIALISED CARE SECTION

                            Text(
                              "Specialised Care",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                specialisedCared.length,
                                (index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.circular(90),
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer
                                                .withOpacity(0.4),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            specialisedCared[index].icon,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(specialisedCared[index].name)
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (index == customIcons.length - 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DatasetGalleryScreen()));
                } else if (index == customIcons.length - 3) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlasmodiumParasiteChecker()));
                } else if (index == customIcons.length - 4) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UploadImage()));
                }
              },
              borderRadius: BorderRadius.circular(90),
              child: Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  customIcons[index].icon,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              customIcons[index].name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: mainAppColor),
            )
          ],
        );
      }),
    );
  }
}

class CustomIcon {
  final String name;
  final String icon;
  // Function()? onTap;

  CustomIcon({
    required this.name,
    required this.icon,
    // this.onTap,
  });
}
