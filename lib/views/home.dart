import 'dart:io';
import 'dart:math';

import 'package:editor/service/ad_service.dart';
import 'package:editor/views/photo_college.dart';
import 'package:editor/views/template.dart';
import 'package:editor/views/theme_screen/theme_screen.dart';
import 'package:editor/widgets/stickers_module/sticker_list.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';

import '../models/sticker_model.dart';
import '../utils/app_colors.dart';
import '../utils/theme.dart';
import '../widgets/textStyle.dart';
import 'Editor/image_editor_pro.dart';
import 'backgroundScreen.dart';
import 'myCreative.dart';

class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const Home(this.scaffoldKey, {Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MySticker> myStickersList = [];

  File? galleryImage;

  void takeGalleryImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        galleryImage = File(pickedImage.path);
        Get.to(
          () => ImageEditorPro(
            appBarColor: Colors.black87,
            bottomBarColor: Colors.black87,
            pathSave: null,
            galleryImage: galleryImage,
          ),
        );
      }
    });
  }

  void takeCameraImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        galleryImage = File(pickedImage.path);
        Get.to(
          () => ImageEditorPro(
            appBarColor: Colors.black87,
            bottomBarColor: Colors.black87,
            pathSave: null,
            galleryImage: galleryImage,
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    selectedElement = Random().nextInt(6);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Get.dialog(
          AlertDialog(
            title: Text('Are you sure?'.tr),
            content: Text('Do you want to exit an App'.tr),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(result: false),
                child: Text('No'.tr),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: Text('Yes'.tr),
              ),
            ],
          ),
        );
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
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
                        image:
                            AssetImage(imageThemes[selectedElement].largeImage),
                        fit: BoxFit.fill)),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  height: AppBar().preferredSize.height,
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          widget.scaffoldKey.currentState!.openDrawer();
                        },
                        icon: Icon(Icons.menu, color: kWhiteColor),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          'Home'.tr,
                          style: myTextStyle(18, FontWeight.w600, kWhiteColor),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () async {
                              await Get.to(() => const ThemeScreen());
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.color_lens,
                              color: kWhiteColor,
                              size: 30,
                            ),
                          )),
                    )
                  ]),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 10),
                          child: Column(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: myCardList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1.8,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                ),
                                itemBuilder: (ctx, i) {
                                  return InkWell(
                                    onTap: () {
                                      if (i == 0) {
                                        takeGalleryImage();
                                      }

                                      if (i == 1) {
                                        takeCameraImage();
                                      }

                                      if (i == 3) {
                                        Get.to(() => const BackgroundScreen());
                                      }
                                      if (i == 5) {
                                        Get.to(() => const CollageScreen());
                                      }
                                      if (i == 2) {
                                        Get.to(() => const MyCreative());
                                      }
                                      if (i == 4) {
                                        Get.to(() => const Template());
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kWhiteColor.withOpacity(0.08),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: Image.asset(
                                              myCardList[i]['image'],
                                              color: kWhiteColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            (myCardList[i]['text'].toString())
                                                .tr,
                                            style: myTextStyle(16,
                                                FontWeight.w200, kWhiteColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                  width: Get.width,
                                  height: 50,
                                  child: AdWidget(ad: AdmobService.bannerAd!)),
                              // const SizedBox(height: 10),
                              const StickerListWidget()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
