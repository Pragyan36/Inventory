import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CloudinaryHelper {
  static const cloudName = 'db1fkkpix';
  static const apiKey = '523863638888717';
  static const apiSecret = '7TSoObVI1pVniEs4aYAZpD';
  static Future<File?> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  static Future<String?> uploadToCloudinary(File imageFile) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // ✅ Create signature: "timestamp=XXXXXX" + apiSecret
    final signatureRaw = 'timestamp=$timestamp$apiSecret';
    final signature = sha1.convert(utf8.encode(signatureRaw)).toString();

    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['timestamp'] = timestamp.toString()
      ..fields['api_key'] = apiKey
      ..fields['signature'] = signature
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final resStr = await response.stream.bytesToString();
      final data = json.decode(resStr);
      return data['secure_url'];
    } else {
      print('❌ Cloudinary upload failed: ${response.statusCode}');
      return null;
    }
  }
}
