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
                _buildDiseaseContainer(
                    'assets/images/mosquito.webp',
                    'Plasmodium FALCIPARUM',
                    'Plasmodium falciparum is the most prevalent and deadly of the malaria parasites, largely responsible for severe clinical malaria and death. It is distinguished by its ability to cause severe blood vessel blockages and complications such as cerebral malaria. Structurally, the parasite demonstrates a complex life cycle involving several stages: sporozoites, merozoites, and gametocytes. The merozoites of P. falciparum are capable of infecting a larger proportion of red blood cells, including those of varying ages, which contributes to its virulence. Its gametocytes are crescent-shaped, facilitating easier identification under a microscope.'),
                _buildDiseaseContainer(
                    'assets/images/Types_of_Malaria.webp',
                    'Plasmodium MALARIAE',
                    "Plasmodium malariae is associated with a less severe form of malaria but can cause chronic infection that may persist for years if untreated. This parasite causes quartan malaria, named for the fever spikes occurring every third day (a 72-hour cycle). The trophozoites and schizonts of P. malariae appear more compact and less amoeboid compared to those of other species. One of the defining structural features of P. malariae is the band-form trophozoites, where the parasite forms a band across the infected red blood cell."),
                _buildDiseaseContainer(
                    'assets/images/Types_of_Malaria.webp',
                    'Plasmodium VIVAX',
                    "Plasmodium vivax is the most widespread malaria parasite outside of sub-Saharan Africa and is particularly prevalent in Asia and Latin America. P. vivax is notorious for its ability to cause relapses by remaining dormant in the liver for months or even years. From a structural viewpoint, P. vivax infects only young red blood cells or reticulocytes. It is characterized by large, irregularly shaped trophozoites and schizonts that distort the host cell, making it larger and stippled with Schüffner's dots visible under staining."),
                _buildDiseaseContainer(
                    'assets/images/Types_of_Malaria.webp',
                    'Plasmodium OVALE',
                    "Plasmodium ovale, similar to P. vivax, causes tertian malaria, where fever spikes every 48 hours. This species is less common and tends to be geographically restricted to West Africa and certain islands in the western Pacific. Structurally, P. ovale resembles P. vivax with its large, oval-shaped schizonts and gametocytes. However, P. ovale is distinguishable by having more compact cytoplasm and enlarged host cells with visible fimbriation on the cell surface."),
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
