import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CloudinaryHelper {
  static Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<String?> uploadImage(File imageFile) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/db1fkkpix/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = "inventoty" // 🔁 Check for spelling!
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    try {
      final response = await request.send();
      final resBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final data = json.decode(resBody);
        print("✅ Image uploaded: ${data['secure_url']}");
        return data['secure_url'];
      } else {
        print("❌ Upload failed: ${response.statusCode}");
        print(resBody);
        return null;
      }
    } catch (e) {
      print("❌ Upload exception: $e");
      return null;
    }
  }
}
