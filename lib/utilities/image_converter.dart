import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

class ImageConverter {
  Future<String> encodeImageToBase64(String imagePath) async {
    final File imageFile = File(imagePath);
    final Uint8List imageBytes = await imageFile.readAsBytes();
    final String base64String = base64Encode(imageBytes);
    return base64String;
  }

  /// Function to decode a Base64 string back to an image file
  Future<void> decodeBase64ToImage(String base64String, String outputPath) async {
    final Uint8List imageBytes = base64Decode(base64String);
    final File imageFile = File(outputPath);
    await imageFile.writeAsBytes(imageBytes);
  }

  Future<String> fileToBase64String(File file) async {
    try {
      final Uint8List fileBytes = await file.readAsBytes();
      final String base64String = base64Encode(fileBytes);
      return base64String;
    } catch (e) {
      throw Exception("Error converting file to Base64: $e");
    }
  }
}