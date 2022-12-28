import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../utils/app_colors.dart';
import '../utils/theme.dart';
import '../widgets/textStyle.dart';

class CollageScreen extends StatefulWidget {
  const CollageScreen({Key? key}) : super(key: key);

  @override
  _CollageScreenState createState() => _CollageScreenState();
}

class _CollageScreenState extends State<CollageScreen> {
  List<String> layoutPaths = [
    'images/college/Group 18827.png',
    'images/college/Group 18828.png',
    'images/college/Group 18829.png',
    'images/college/Group 18830.png',
    'images/college/Group 18832.png',
    'images/college/Group 18833.png',
    'images/college/Group 18834.png',
    'images/college/Group 18835.png',
    'images/college/Group 18836.png',
    'images/college/Group 18837.png',
    'images/college/Group 18838.png',
    'images/college/Group 18839.png',
  ];

  List<File> images = [];

  void takeGalleryImage(int imagesLength, int index) async {
    images = [];
    final pickedImage = await ImagePicker().pickMultiImage();
    if (pickedImage != null) {
      if (imagesLength == pickedImage.length) {
        for (var element in pickedImage) {
          images.add(File(element.path));
        }
        setState(() {});
        Get.back();
        Get.to(() => PhotoCollegeView(photoCollegeLayout[index], images));
      } else {
        Get.snackbar('Incorrect'.tr,
            'Please select'.tr + '$imagesLength ' + 'images!'.tr,
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              height: double.infinity,
              decoration: isColors
                  ? BoxDecoration(
                      gradient: LinearGradient(
                          colors: isDark
                              ? darkColors[selectedElement]
                              : lightColors[selectedElement],
                          end: Alignment.bottomRight,
                          begin: Alignment.topLeft))
                  : BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              imageThemes[selectedElement].largeImage),
                          fit: BoxFit.fill)),
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    width: double.infinity,
                    height: AppBar().preferredSize.height,
                    child: Row(children: [
                      Expanded(
                        // flex: 1,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Center(
                          child: Text(
                            'Choose Photo College'.tr,
                            style:
                                myTextStyle(18, FontWeight.w600, kWhiteColor),
                          ),
                        ),
                      ),
                      Expanded(
                        // flex: 1,
                        child: Text(
                          '',
                          style: myTextStyle(18, FontWeight.w300, kWhiteColor),
                        ),
                      )
                    ]),
                  ),
                  GridView.builder(
                    itemCount: layoutPaths.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                    itemBuilder: (ctx, i) {
                      return InkWell(
                        onTap: () {
                          buildBottomSheet(i);
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.2),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(layoutPaths[i]))),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )
                ]),
              ))),
    );
  }

  List<College> photoCollegeLayout = [
    College(tiles: const [
      // StaggeredTile.count(2, 2),
      // StaggeredTile.count(2, 2),
      // StaggeredTile.count(2, 2),
      // StaggeredTile.count(2, 2),
    ], children: [
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
    ], mainAxisSpacing: 4, crossAxisCount: 4, crossAxisSpacing: 4),
    College(tiles: const [
      // StaggeredTile.count(2, 1),
      // StaggeredTile.count(1, 2),
      // StaggeredTile.count(1, 2),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(2, 1),
    ], children: [
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
    ], mainAxisSpacing: 4, crossAxisCount: 3, crossAxisSpacing: 4),
    College(tiles: const [
      // StaggeredTile.count(2, 3),
      // StaggeredTile.count(2, 3),
    ], children: [
      buildPhotoContainer(),
      buildPhotoContainer(),
    ], mainAxisSpacing: 4, crossAxisCount: 4, crossAxisSpacing: 4),
    College(tiles: const [
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(2, 3),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
    ], children: [
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
    ], mainAxisSpacing: 4, crossAxisCount: 4, crossAxisSpacing: 4),
    College(tiles: const [
      // StaggeredTile.count(4, 2),
      // StaggeredTile.count(4, 2),
    ], children: [
      buildPhotoContainer(),
      buildPhotoContainer(),
    ], mainAxisSpacing: 4, crossAxisCount: 4, crossAxisSpacing: 4),
    College(tiles: const [
      // StaggeredTile.count(2, 3),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
    ], children: [
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
    ], mainAxisSpacing: 4, crossAxisCount: 3, crossAxisSpacing: 4),
    College(tiles: const [
      // StaggeredTile.count(2, 2),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
    ], children: [
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
    ], mainAxisSpacing: 4, crossAxisCount: 4, crossAxisSpacing: 4),
    College(tiles: const [
      // StaggeredTile.count(2, 2),
      // StaggeredTile.count(2, 2),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
    ], children: [
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
    ], mainAxisSpacing: 4, crossAxisCount: 4, crossAxisSpacing: 4),
    College(tiles: const [
      // StaggeredTile.count(4, 2),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
    ], children: [
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
    ], mainAxisSpacing: 4, crossAxisCount: 4, crossAxisSpacing: 4),
    College(tiles: const [
      // StaggeredTile.count(2, 2),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
    ], children: [
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
    ], mainAxisSpacing: 4, crossAxisCount: 3, crossAxisSpacing: 4),
    College(tiles: const [
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(2, 2),
      // StaggeredTile.count(1, 1),
    ], children: [
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
    ], mainAxisSpacing: 4, crossAxisCount: 3, crossAxisSpacing: 4),
    College(tiles: const [
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(3, 2),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
      // StaggeredTile.count(1, 1),
    ], children: [
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
      buildPhotoContainer(),
    ], mainAxisSpacing: 4, crossAxisCount: 5, crossAxisSpacing: 4),
  ];

  void buildBottomSheet(int i) {
    Get.bottomSheet(Container(
      width: double.infinity,
      height: Get.height * 0.3,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Please select".tr +
                " ${photoCollegeLayout[i].children.length} " +
                "images!".tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            shape: const OutlineInputBorder(),
            onPressed: () {
              takeGalleryImage(photoCollegeLayout[i].children.length, i);
            },
            child: Text('Select Images'.tr),
          )
        ],
      ),
    ));
  }
}

buildPhotoContainer() {
  return Container(
    // color: Colors.teal,
    decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
                'https://images.unsplash.com/photo-1655784978562-5c56854dedf7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60'))),
  );
}

class College {
  List<Widget> tiles = [];
  List<Widget> children = [];
  double mainAxisSpacing;
  double crossAxisSpacing;
  int crossAxisCount;

  College(
      {required this.children,
      required this.crossAxisCount,
      required this.crossAxisSpacing,
      required this.mainAxisSpacing,
      required this.tiles});
}

// ignore: must_be_immutable
class PhotoCollegeView extends StatefulWidget {
  College college;

  PhotoCollegeView(this.college, this.images, {Key? key}) : super(key: key);

  List<File> images;

  @override
  _PhotoCollegeViewState createState() => _PhotoCollegeViewState();
}

class _PhotoCollegeViewState extends State<PhotoCollegeView> {
  final ScreenshotController _screenshotController = ScreenshotController();

  void onSave() async {
    PermissionStatus p = await Permission.storage.request();

    bool isGranted = p.isGranted;

    if (!isGranted) {
      PermissionStatus p1 = await Permission.storage.request();

      if (p1.isGranted) {
        isGranted = true;
      }
    }

    if (isGranted) {
      _screenshotController
          .capture(pixelRatio: 1.5)
          .then((binaryIntList) async {
        final paths = await getApplicationDocumentsDirectory();

        final file =
            await File('${paths.path}/' + DateTime.now().toString() + '.jpg')
                .create();

        file.writeAsBytesSync(binaryIntList!);
        GallerySaver.saveImage(file.path).then((success) async {
          Get.snackbar('Success'.tr, 'Image Saved'.tr,
              snackPosition: SnackPosition.TOP,
              backgroundColor: kPrimaryColor,
              colorText: Colors.white);
        });
      }).catchError((onError) {});
    }
  }

  Widget buildPhotoContainer(File image) {
    return Container(
      // color: Colors.teal,
      decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: FileImage(image))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: double.infinity,
          decoration: isColors
              ? BoxDecoration(
                  gradient: LinearGradient(
                      colors: isDark
                          ? darkColors[selectedElement]
                          : lightColors[selectedElement],
                      end: Alignment.bottomRight,
                      begin: Alignment.topLeft))
              : BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage(imageThemes[selectedElement].largeImage),
                      fit: BoxFit.fill)),
          child: Column(children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ))
              ],
            ),
            Screenshot(
              controller: _screenshotController,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: StaggeredGrid.count(
                      // shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: widget.college.crossAxisCount,
                      mainAxisSpacing: widget.college.mainAxisSpacing,
                      crossAxisSpacing: widget.college.crossAxisSpacing,

                      // StaggeredGrid: widget.college.tiles,
                      children: widget.images
                          .map((e) => buildPhotoContainer(e))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              onPressed: onSave,
              child: Text(
                "Save".tr,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
