import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

class CustomConverter{
  static file_to_base64(String path){
    File file = File(path);
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  static get_extension_from_path(String path){
    return p.extension(path);
  }
}