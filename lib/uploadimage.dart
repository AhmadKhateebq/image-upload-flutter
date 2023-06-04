import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'dart:io';

const _url = "http://10.0.2.2:8085/images/upload";
String getImageName(File imageFile) {
  String imageName = path.basename(imageFile.path);
  print('Image Name: $imageName');
  return imageName;
}

Future<String> uploadImage(File imageFile) async {
  var request = http.MultipartRequest('POST', Uri.parse(_url));
  request.files.add(http.MultipartFile(
    'image',
    imageFile.readAsBytes().asStream(),
    imageFile.lengthSync(),
    filename: getImageName(imageFile),
  ));

  var response = await request.send();
  var responseString = await response.stream.bytesToString();
  print(responseString);
  if (response.statusCode == 200) {
    return 'Image uploaded successfully';
  } else {
    return 'Image upload failed';
  }
}
