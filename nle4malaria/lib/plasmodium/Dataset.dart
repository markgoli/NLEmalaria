import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nle4malaria/styles/color.dart';

class DatasetGalleryScreen extends StatefulWidget {
  @override
  _DatasetGalleryScreenState createState() => _DatasetGalleryScreenState();
}

class _DatasetGalleryScreenState extends State<DatasetGalleryScreen> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final ListResult result = await storage.ref('Uploads_Dataset/').listAll();
    List<String> urls = [];
    for (var ref in result.items) {
      final url = await ref.getDownloadURL();
      urls.add(url);
    }
    setState(() {
      imageUrls = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        title: const Text(
          'Dataset',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily:
                'Roboto', // Specify the font family if you have a custom font
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(98, 149, 162, 1),
          ),
        ),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Image.network(imageUrls[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
