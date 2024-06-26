// ignore_for_file: unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:nle4malaria/components/Buttons.dart';
import 'package:nle4malaria/Services/firebase_storage_service.dart';
import 'package:nle4malaria/config/extensions.dart';
import 'package:nle4malaria/plasmodium/results.dart';
import 'package:nle4malaria/styles/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as devtools;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  late String _imageUrl;
  double confidence = 0.0;
  String label = '';
  String caption = '';
  String API_J = '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';

  Future<void> _tfliteInit() async {
    try {
      String? res = await Tflite.loadModel(
          model: "assets/models/model_unquant.tflite",
          labels: "assets/models/labels.txt",
          numThreads: 1,
          isAsset: true,
          useGpuDelegate: false);
      devtools.log('Model loaded: $res');
    } catch (e) {
      devtools.log('Failed to load model: $e');
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      devtools.log("No image selected.");
      return;
    }

    setState(() {
      image = File(pickedFile.path);
      uploadImageToFirebase();
      fetchCaption(pickedFile.path);
    });

    try {
      var recognitions = await Tflite.runModelOnImage(
          path: pickedFile.path,
          imageMean: 0.0,
          imageStd: 255.0,
          numResults: 2,
          threshold: 0.2,
          asynch: true);

      if (recognitions == null || recognitions.isEmpty) {
        devtools.log("No recognitions.");
        return;
      }

      devtools.log(recognitions.toString());
      setState(() {
        confidence = recognitions[0]['confidence'] * 100;
        label = recognitions[0]['label'].toString();
      });
    } catch (e) {
      devtools.log('Error running model: $e');
    }
  }

  Future uploadImageToFirebase() async {
    if (image == null) return;
    String imageUrl = await FirebaseStorageService.uploadFile(image!);

    setState(() {
      _imageUrl = imageUrl;
    });
  }

  // Upload image to API for testing.

  Future<void> uploadImageToAPI() async {
    if (image == null) return;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:8000/'),
    );
    request.files.add(await http.MultipartFile.fromPath('image', image!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final decodedData = json.decode(responseData);
      setState(() {
        caption = decodedData['caption'];
      });
    } else {
      print('Failed to upload image.');
    }
  }

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

  Future<String> encodeImageToBase64(String imagePath) async {
    final bytes = await File(imagePath).readAsBytes();
    return base64Encode(bytes);
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  void initState() {
    uploadImageToAPI();
    super.initState();
    _tfliteInit().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Microscopy',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(98, 149, 162, 1),
          ),
        ),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: grey2, borderRadius: BorderRadius.circular(10)),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Color.fromRGBO(98, 149, 162, 1),
                child: image == null
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/setup.png',
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Place your phone camera to the eyepiece of your microscope, capture the image and upload it for prediction and classification.',
                              style: TextStyle(fontSize: 12, color: mainBlue),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Container(
                        height: 280,
                        width: 280,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          // color: lightBlue,
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                          image: image == null
                              ? const DecorationImage(
                                  image: AssetImage('assets/upload.jpg'),
                                )
                              : DecorationImage(
                                  image: FileImage(
                                    image!,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                        ),
                        child: Column(
                          children: [
                            220.height(),
                            UploadButton(
                              onTap: () {
                                if (image != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Results(
                                        image: image,
                                        label: label,
                                        caption: caption,
                                      ),
                                    ),
                                  );
                                } else {
                                  // Handle the case where _filePath is null, e.g., show an error message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Please select an image first.')),
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.recent_actors_outlined,
                                color:
                                    white, // image: Image.network(_imageUrl),
                              ),
                              text: 'See full Diagnostic Report',
                            ),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 50),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Classified as: $label',
                        style: const TextStyle(
                          color: greenColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "The Accuracy is ${confidence.toStringAsFixed(0)}%",
                        // 'Number of pathogens detected ${confidence.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: mainBlue,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: mainBlue,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Or ',
                        style: TextStyle(color: mainBlue),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: mainBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              UploadButton(
                onTap: () {
                  pickImage(ImageSource.camera);
                },
                text: 'Use Camera',
                icon: Icon(
                  Icons.camera,
                  color: white,
                ),
              ),
              30.height(),
              UploadButton(
                onTap: () {
                  pickImage(ImageSource.gallery);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Results()),
                  // );
                  // Results();
                },
                icon: Icon(
                  Icons.image,
                  color: white,
                ),
                text: 'Select from Gallery',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
