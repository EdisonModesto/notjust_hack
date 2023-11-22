import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudService {
  Future<String> uploadImage(FilePickerResult result) async {
    // Retrieve the image file
    PlatformFile file = result.files.first;

    // Create a unique filename using the current timestamp
    String fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';

    // Create a reference to the storage location
    Reference storageReference = FirebaseStorage.instance.ref().child('images/$fileName');

    // Upload the image file to the storage location
    await storageReference.putFile(File(file.path!));

    // Get the download URL of the uploaded image
    String downloadURL = await storageReference.getDownloadURL();

    // Return the download URL
    return downloadURL;
  }
}
