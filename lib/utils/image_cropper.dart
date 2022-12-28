import '../views/Editor/imports.dart';

Future<File> cropImage(File image) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: image.path,
    aspectRatioPresets: Platform.isAndroid
        ? [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]
        : [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
    // androidUiSettings: AndroidUiSettings(
    //     toolbarTitle: 'Crop Image',
    //     toolbarColor: const Color(0xff49ADF3),
    //     toolbarWidgetColor: kWhiteColor,
    //     initAspectRatio: CropAspectRatioPreset.original,
    //     activeControlsWidgetColor: const Color(0xff49ADF3),
    //     lockAspectRatio: false),
    // iosUiSettings: const IOSUiSettings(
    //   title: 'Cropper',
    // ),
  );
  if (croppedFile != null) {
    image = File(croppedFile.path);
  }

  return File(image.path);
}
