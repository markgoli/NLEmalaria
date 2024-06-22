import 'package:flutter/material.dart';
import 'package:nle4malaria/styles/color.dart';

class PlasmodiumParasiteChecker extends StatelessWidget {
  const PlasmodiumParasiteChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'More about Pathogen Types',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily:
                'Roboto', // Specify the font family if you have a custom font
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: mainBlue),
        ),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(2),
            sliver: SliverGrid.count(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 1,
              children: <Widget>[
                _buildDiseaseContainer('assets/images/Types_of_Malaria.webp',
                    'Types of Malaria', ''),
                _buildDiseaseContainer('assets/images/mosquito.webp',
                    'Femala Anopheles Mosquito', ''),
                _buildDiseaseContainer('assets/images/FIG05.jpg',
                    'The different plasmodia types', ''),
                _buildDiseaseContainer(
                  'assets/images/distribution.jpg',
                  'The distribution of Malaria through Plasmodium Falciparum and Vivax.',
                  '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseaseContainer(
      String imagePath, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: Image.asset(
              imagePath,
              width: 320,
              height: 290,
              fit: BoxFit.fitWidth,
            ),
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(4),
          //   child: Image.asset(
          //     imagePath,
          //     width: 220,
          //     height: 220,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          const SizedBox(height: 8),
          Text(
            title,
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
          if (description.isNotEmpty) const SizedBox(height: 8),
          if (description.isNotEmpty)
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
              ),
            ),
        ],
      ),
    );
  }
}
