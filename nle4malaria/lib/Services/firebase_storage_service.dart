import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static Future<String> uploadFile(File image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    var snapshot = await storage
        .ref('Uploads_Dataset/image_${DateTime.now().toIso8601String()}')
        .putFile(image);
    return await snapshot.ref.getDownloadURL();
  }

  static Future<List<String>> listAllImages() async {
    List<String> images_dataset = [];
    FirebaseStorage storage = FirebaseStorage.instance;
    final ListResult result = await storage.ref('Uploads_Dataset/').listAll();
    for (var ref in result.items) {
      final url = await ref.getDownloadURL();
      images_dataset.add(url);
    }
    return images_dataset;
  }
}
