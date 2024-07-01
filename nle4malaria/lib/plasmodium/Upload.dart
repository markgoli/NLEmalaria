import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageCaptioning extends StatefulWidget {
  const ImageCaptioning({super.key});

  @override
  State<ImageCaptioning> createState() => _ImageCaptioningState();
}

class _ImageCaptioningState extends State<ImageCaptioning> {
  File? image;
  late String _imageUrl;
  double confidence = 0.0;
  String label = '';
  String caption = '';

  Future<void> fetchCaption(String imagePath) async {
    const String apiKey =
        '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'; // Use your Hugging Face API key
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    String imageBase64 = base64Encode(File(imagePath).readAsBytesSync());
    final response = await http.post(
      Uri.parse(
          'https://api-inference.huggingface.co/models/BRIAN12682/malaria-captioning-v2'),
      headers: headers,
      body: jsonEncode({'inputs': imageBase64}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        caption = data[
            'generated_text']; // Ensure you have a state variable for caption
      });
    } else {
      print('Failed to fetch caption: ${response.statusCode}');
      print(response.body);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        image =
            File(pickedFile.path); // Ensure you have a state variable for image
      });

      // Optionally upload to Firebase or directly use the file path
      fetchCaption(
          pickedFile.path); // Call to fetch the caption from Hugging Face
    } else {
      print("No image selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image and Fetch Caption'),
      ),
      body: Column(
        children: [
          image != null
              ? Image.file(image!)
              : Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Icon(Icons.image, size: 100)),
          TextButton(
            onPressed: () => pickImage(ImageSource.gallery),
            child: Text('Pick Image from Gallery'),
          ),
          TextButton(
            onPressed: () => pickImage(ImageSource.camera),
            child: Text('Capture Image from Camera'),
          ),
          SizedBox(height: 20),
          Text(caption ??
              'Caption will appear here...'), // Ensure you have a state variable for caption
        ],
      ),
    );
  }
}
