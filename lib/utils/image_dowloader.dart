import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<File> urlToFile(String imageUrl) async {
  var rng =   Random();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file =   File(tempPath + (rng.nextInt(100)).toString() + '.png');
  http.Response response = await http.get(Uri.parse(imageUrl));
  await file.writeAsBytes(response.bodyBytes);
  return file;
}

Future<File?> getImageToFile({required Function onStart,required Function onEnd,String? bgImagePath, String? stickerImagePath}) async {
  File? image;
  onStart();
  if (bgImagePath != null) {
    image = await urlToFile(bgImagePath);
  } else if (stickerImagePath != null) {
    image = await urlToFile(stickerImagePath);
  } else {

  }

 onEnd();
  return image;
}