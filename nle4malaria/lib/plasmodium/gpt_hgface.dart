import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchCaption(String imagePath) async {
  try {
    // Replace 'YOUR_HUGGINGFACE_API_KEY' with your actual Hugging Face API key
    const String apiKey = 'YOUR_HUGGINGFACE_API_KEY';
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    // Image data should be encoded in base64
    String imageBase64 = await encodeImageToBase64(imagePath);

    final response = await http.post(
      Uri.parse(
          'https://api-inference.huggingface.co/models/BRIAN12682/malaria-captioning-v2'),
      headers: headers,
      body: jsonEncode({'inputs': imageBase64}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // Handle the response as needed, e.g., displaying the caption
      print('Caption: ${data['generated_text']}');
    } else {
      print('Failed to fetch caption: ${response.body}');
    }
  } catch (e) {
    print('Error fetching caption: $e');
  }
}

Future<String> encodeImageToBase64(String imagePath) async {
  final bytes = await File(imagePath).readAsBytes();
  return base64Encode(bytes);
}
