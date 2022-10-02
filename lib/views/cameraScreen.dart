import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/app_colors.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? cameraImage;
  void takeCameraImage() async {
    final pickedImage =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    setState(() {
      cameraImage = File(pickedImage!.path);
    });
  }

  @override
  void initState() {
    takeCameraImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: kBlackColor,
        ),
      ),
    );
  }
}
