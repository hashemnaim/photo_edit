import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:image/image.dart' as imageLib;
import 'dart:math' as math;
import 'package:editor/views/Editor/block_picker.dart' as block;

import 'bottomBarContainer.dart' as b;
import 'emojies_view.dart' as e;

// import 'package:http/http.dart' as http;
import 'imports.dart';

List<TextModel> widgetJson = [];

// List<String> myScreenStickers = [];
// bool isContainerExist = false;
double imageAngle = 0;
// double imageHeight = 100.0;
// double imageWidth = 100.0;

// ignore: must_be_immutable
class ImageEditorPro extends StatefulWidget {
  Color? appBarColor;
  Color? bottomBarColor;
  Color? backgroundColor;
  String? backgroundImagePath;
  String? stickerNetworkImage;
  Directory? pathSave;
  double? pixelRatio;
  File? galleryImage;

  ImageEditorPro({
    Key? key,
    this.appBarColor,
    this.bottomBarColor,
    this.backgroundImagePath,
    this.stickerNetworkImage,
    this.backgroundColor,
    this.pathSave,
    this.pixelRatio,
    this.galleryImage,
  }) : super(key: key);

  @override
  _ImageEditorProState createState() => _ImageEditorProState();
}

var slider = 0.0;

class _ImageEditorProState extends State<ImageEditorPro> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  // TabController? tabController;
  double xAxisShadow = 0.0;
  double yAxisShadow = 0.0;
  double showBlurRadius = 0.0;
  bool isCurved = false;
  TextAlign? align;
  bool isEdit = false;

  List type = [];

  // List<StickerModel> stickersList = [];
  String? currentFrame;
  bool isSticker = true;
  int currentStickerIndex = 0;

  TextEditingController name = TextEditingController();
  double textOpacity = 1.0;
  double curveRadius = 20.0;
  double curveAngle = 4.0;
  double backgroundOpacity = 1.0;
  double borderOpacity = 1.0;
  Color backgroundBorderColor = Colors.transparent;
  double backgroundBorderSize = 1.0;

  // var decodedImage;
  File? imageFile;
  String? fileName;
  double textFontSize = 15.0;
  double textBorderRadius = 0.0;
  double textBorderSize = 0.0;
  double textBorderOpacity = 1.0;
  double textBackgroundOpacity = 0.1;
  bool isTextViewTrue = false;

  double offsetAngle = 0.0;

  int currentFilter = 0;

  Map<String, List<int>> cachedFilters = {};
  var circleShape = false;

  // imageLib.Image? image;

  // Filter? _filter;
  bool isStickerTrue = false;

  final GlobalKey container = GlobalKey();
  final GlobalKey globalKey = GlobalKey();
  File? _image;
  ScreenshotController screenshotController = ScreenshotController();

  Color shadowColor = Colors.red;

  double imageBorderWidth = 0.0;
  double stickerBorderSize = 0.0;
  Color imageBorderColor = kBlackColor;
  List<Offset> offsets = [];
  Offset offset1 = Offset.zero;
  Offset offset2 = Offset.zero;
  var openBottomSheet = false;
  var openFonts = false;
  var openFontFamily = false;
  var openShadow = false;
  var openResize = false;
  var openTextColor = false;
  var openBackgroundColor = false;
  var openTextFormat = false;
  var openTextOpacity = false;
  var openCurveText = false;
  var openRotation = false;
  var openFrames = false;
  var openStickers = false;
  var openFilter = false;
  var openTextField = false;

  var imageList = <ImageModelEditing>[].obs;

  Widget getTitle() {
    String title = '';
    if (openRotation) {
      title = 'Rotation';
    } else if (openFilter) {
      title = 'Filters';
    } else if (openStickers) {
      title = 'Stickers';
    } else if (openFrames) {
      title = 'Frames';
    } else if (openCurveText) {
      title = 'Curve Text';
    } else if (openTextOpacity) {
      title = 'Text Opacity';
    } else if (openTextFormat) {
      title = 'Text Alignment';
    } else if (openBackgroundColor) {
      title = 'Background Color';
    } else if (openTextColor) {
      title = 'Text Color';
    } else if (openResize) {
      title = 'Resize';
    } else if (openShadow) {
      title = 'Shadow';
    } else if (openFontFamily) {
      title = 'Fonts';
    } else if (openFonts) {
      title = 'Styles';
    } else {
      title = 'Menu';
    }

    return Text(
      title,
      style: TextStyle(
          color: kWhiteColor, fontWeight: FontWeight.w400, fontSize: 14),
    );
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void dispose() {
    widgetJson.clear();
    super.dispose();
  }

  bool isLoading = false;

  @override
  void initState() {
    AdmobService.initilizeInterstitial();
    if (widget.galleryImage != null) {
      _image = widget.galleryImage!;
    } else {
      getImageToFile(
              onStart: () {
                isLoading = true;
                setState(() {});
              },
              onEnd: () {
                setState(() {
                  isLoading = false;
                });
              },
              bgImagePath: widget.backgroundImagePath,
              stickerImagePath: widget.stickerNetworkImage)
          .then((value) {
        _image = value;
        setState(() {});
      });
    }
    type.clear();
    offsets.clear();
    // tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    // _filter = presetFiltersList[0];

    super.initState();
  }

  double flipValue = 0;
  int rotateValue = 0;
  double blurValue = 0;
  double opacityValue = 0;
  Color colorValue = Colors.transparent;

  double hueValue = 0;
  double brightnessValue = 0;
  double saturationValue = 0;
  Color pickerColorBlock = const Color(0xff443a49);

  void changeColorBlock(Color color) {
    TextModel currentJsonWidget =
        widgetJson.firstWhere((element) => element.isEdit == true);

    int currentJsonIndex = widgetJson.indexOf(currentJsonWidget);

    setState(() => widgetJson[currentJsonIndex].myFontModel?.textColor = color);
  }

  Widget myColorPicker() {
    return block.BlockPicker(
      pickerColor: widgetJson[0].myFontModel?.textColor,
      onColorChanged: changeColorBlock,
    );
  }

  // DataController? dataController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: AppBar().preferredSize.height,
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
                              imageThemes[selectedElement].smallImage),
                          fit: BoxFit.fill)),
              child: Row(children: [
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back_ios, color: kWhiteColor),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Text(
                      '',
                      style: myTextStyle(18, FontWeight.w600, kWhiteColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    for (var e in widgetJson) {
                      e.isEdit = false;
                    }
                    openTextField = false;
                    setState(() {});
                    screenshotController.capture().then((binaryIntList) async {
                      final paths = widget.pathSave ??
                          await getApplicationDocumentsDirectory();

                      final file = await File('${paths.path}/' +
                              DateTime.now().toString() +
                              '.jpg')
                          .create();

                      file.writeAsBytes(binaryIntList!).then((value) {
                        Share.shareFiles([value.path]);
                      });
                    }).catchError((onError) {
                      if (kDebugMode) {
                        print(onError);
                      }
                    });
                  },
                  child: Container(
                    // width: 20,
                    // height: 20,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Image.asset(
                      'images/newIcons/share (6).png',
                      width: 22,
                      height: 22,
                      color: kWhiteColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    AdmobService.interstitialAd!.show().then((value) {
                      AdmobService.initilizeInterstitial();
                    });
                    for (var e in widgetJson) {
                      e.isEdit = false;
                    }

                    for (var element in imageList) {
                      element.isEdit = false;
                    }
                    openTextField = false;
                    setState(() {});

                    screenshotController.capture().then((binaryIntList) async {
                      final paths = widget.pathSave ??
                          await getApplicationDocumentsDirectory();

                      if (kDebugMode) {
                        print("Path is ${paths.path}");
                      }

                      final file = await File('${paths.path}/' +
                              DateTime.now().toString() +
                              '.jpg')
                          .create();

                      if (kDebugMode) {
                        print(file);
                      }

                      file.writeAsBytesSync(binaryIntList!);
                      GallerySaver.saveImage(file.path).then((success) async {
                        if (widget.galleryImage != null) {
                          widget.galleryImage!.delete();
                        }

                        Get.snackbar('Success', 'Image Saved',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: kPrimaryColor,
                            colorText: kWhiteColor);
                      });
                    }).catchError((onError) {
                      if (kDebugMode) {
                        print(onError);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      'images/newIcons/download (4) (1).png',
                      width: 22,
                      height: 22,
                      color: kWhiteColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ]),
            ),
            Expanded(
              child: Container(
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
                                imageThemes[selectedElement].smallImage),
                            fit: BoxFit.fill)),
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (kDebugMode) {
                            print('isEdit clicked');
                          }
                          setState(() {
                            for (var e in widgetJson) {
                              e.isEdit = false;
                            }

                            for (var element in imageList) {
                              element.isEdit = false;
                            }
                          });
                        },
                        child: Center(
                          child: Screenshot(
                            controller: screenshotController,
                            child: RotatedBox(
                              quarterTurns: rotateValue,
                              child: SizedBox(
                                width: double.infinity,
                                height: 500,
                                child: RepaintBoundary(
                                  key: globalKey,
                                  child: Stack(
                                    children: [
                                      Stack(
                                        children: [
                                          _image != null ||
                                                  widget.backgroundImagePath !=
                                                      null ||
                                                  widget.stickerNetworkImage !=
                                                      null
                                              ? Transform(
                                                  alignment: Alignment.center,
                                                  transform: Matrix4.rotationY(
                                                      flipValue),
                                                  child: Stack(
                                                    children: [
                                                      isLoading
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                                  ColorFiltered(
                                                                colorFilter:
                                                                    ColorFilter.matrix(
                                                                        filters[
                                                                            currentFilter]),
                                                                child: Transform
                                                                    .rotate(
                                                                  angle:
                                                                      imageAngle,
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        Get.height *
                                                                            0.62,
                                                                    width: 400,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          width:
                                                                              imageBorderWidth,
                                                                          color: imageBorderWidth < 1
                                                                              ? Colors.transparent
                                                                              : imageBorderColor),
                                                                      image:
                                                                          DecorationImage(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: FileImage(
                                                                            _image!),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),


                                                      Container(
                                                          width:
                                                              double.infinity,
                                                          child: BackdropFilter(
                                                            filter: ImageFilter
                                                                .blur(
                                                              sigmaX: blurValue,
                                                              sigmaY: blurValue,
                                                            ),
                                                            child: Container(
                                                              color: colorValue
                                                                  .withOpacity(
                                                                      opacityValue),
                                                            ),
                                                          )),
                                                      currentFrame == null
                                                          ? Container()
                                                          : Container(
                                                              height:
                                                                  Get.height *
                                                                      0.65,
                                                              width: Get.width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                // color: Colors.red.withOpacity(0.3),
                                                                image: DecorationImage(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    image: NetworkImage(
                                                                        currentFrame!)),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                      ...widgetJson.asMap().entries.map(
                                        (f) {
                                          return widgetJson[f.key].type == 1
                                              ?

                                              ///Uncomment bellow Code from here
                                              e.EmojiView(
                                                  onDelete: (index) {
                                                    widgetJson.removeAt(index);
                                                    setState(() {});
                                                  },
                                                  left: offsets[f.key].dx,
                                                  top: offsets[f.key].dy,
                                                  onPanUpdate: (details) {
                                                    setState(() {
                                                      offsets[f.key] = Offset(
                                                          offsets[f.key].dx +
                                                              details.delta.dx,
                                                          offsets[f.key].dy +
                                                              details.delta.dy);
                                                    });
                                                  },
                                                  mapJson: f.value,
                                                  index: f.key,
                                                )

                                              /// till here
                                              : widgetJson[f.key].type == 2
                                                  ? TextView(
                                                      f.value.width,
                                                      f.value.myFontModel
                                                          ?.isUseCurved,
                                                      left: offsets[f.key].dx,
                                                      top: offsets[f.key].dy,
                                                      onEdit: () {
                                                        isEdit = true;
                                                        name.text =
                                                            widgetJson[f.key]
                                                                .name!;
                                                        openTextField = true;
                                                        setState(() {});
                                                      },
                                                      onPanUpdate: (details) {
                                                        setState(() {
                                                          offsets[f.key] =
                                                              Offset(
                                                                  offsets[f.key]
                                                                          .dx +
                                                                      details
                                                                          .delta
                                                                          .dx,
                                                                  offsets[f.key]
                                                                          .dy +
                                                                      details
                                                                          .delta
                                                                          .dy);
                                                        });
                                                      },
                                                      mapJson: f.value,
                                                      textStyle:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.textStyle,
                                                      myShadow:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.textShadow,
                                                      fontSize:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.textFontSize,
                                                      currentColor:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.textColor,
                                                      borderRadius: widgetJson[
                                                              f.key]
                                                          .myFontModel
                                                          ?.textBorderRadius,
                                                      backgroundColor: widgetJson[
                                                              f.key]
                                                          .myFontModel
                                                          ?.textBackgroundColor,
                                                      paddingWidth:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.textFontWidth,
                                                      paddingHeight:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.textFontHeight,
                                                      myAlignment:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.myAlignment,
                                                      backgroundBorderColor:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.backgroundBorderColor,
                                                      backgroundBorderSize:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.textBackgroundBorderSize,
                                                      backgroundOpacity:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.textBackgroundOpacity,
                                                      borderOpacity: widgetJson[
                                                              f.key]
                                                          .myFontModel
                                                          ?.textBorderOpacity,
                                                      textOpacity:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.textOpacity,
                                                      curveRadius: curveRadius,
                                                      curveAngle: curveAngle,
                                                      fontWeight:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.fontWeight,
                                                      textDecoration:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.textDecoration,
                                                      fontStyle:
                                                          widgetJson[f.key]
                                                              .myFontModel
                                                              ?.fontStyle,
                                                    )
                                                  : widgetJson[f.key].type == 3
                                                      ? Positioned(
                                                          left:
                                                              offsets[f.key].dx,
                                                          top:
                                                              offsets[f.key].dy,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              for (var e
                                                                  in widgetJson) {
                                                                e.isEdit =
                                                                    false;
                                                              }
                                                              setState(() {
                                                                f.value.isEdit =
                                                                    true;
                                                              });
                                                            },
                                                            onPanUpdate:
                                                                (details) {
                                                              setState(() {
                                                                offsets[
                                                                    f
                                                                        .key] = Offset(
                                                                    offsets[f.key]
                                                                            .dx +
                                                                        details
                                                                            .delta
                                                                            .dx,
                                                                    offsets[f.key]
                                                                            .dy +
                                                                        details
                                                                            .delta
                                                                            .dy);
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                isSticker
                                                                    ? buildStickerWidget(
                                                                        f)
                                                                    : Container(),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : Container();
                                        },
                                      ).toList(),
                                      ...imageList.asMap().entries.map((f) {
                                        return imageElement(f.key);
                                      }).toList(),
                                      showTextWidgetForTyping(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: openBottomSheet
            ? Container()
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
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
                                imageThemes[selectedElement].smallImage),
                            fit: BoxFit.fill)),
                height: Get.height * 0.28,
                width: Get.width,
                child: Column(
                  children: [
                    Expanded(
                      child: openFonts
                          ? showOpenFontsWidget()
                          : openFontFamily
                              ? showOpenFontFamilyWidget()
                              : openShadow
                                  ? showOpenShadowWidget()
                                  : openResize
                                      ? showOpenResizeWidget()
                                      : openTextColor
                                          ? showOpenTextColorWidget()
                                          : openBackgroundColor
                                              ? showBackgroundColorWidget()
                                              : openTextFormat
                                                  ? showOpenTextFormatWidget()
                                                  : openTextOpacity
                                                      ? showOpenTextOpacityWidget()
                                                      : openCurveText
                                                          ? showOpenCurveTextWidget()
                                                          : openRotation
                                                              ? showOpenRotationWidget()
                                                              : openFrames
                                                                  ? showFramesWidget()
                                                                  : openStickers
                                                                      ? showStickersWidget()
                                                                      : openFilter
                                                                          ? showOpenFilterWidget()
                                                                          : openMainMenuWidget(
                                                                              context),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget imageElement(int index) {
    return Positioned(
        left: imageList[index].left,
        top: imageList[index].top,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                for (var e in imageList) {
                  e.isEdit = false;
                }

                imageList[index].isEdit = true;
                setState(() {});
              },
              onPanUpdate: (details) {
                for (var e in widgetJson) {
                  e.isEdit = false;
                }
                for (var e in imageList) {
                  e.isEdit = false;
                }

                imageList[index].isEdit = true;
                setState(() {
                  imageList[index].left =
                      imageList[index].left! + details.delta.dx;

                  imageList[index].top =
                      imageList[index].top! + details.delta.dy;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: imageList[index].isEdit!
                      ? BoxDecoration(
                          border: Border.all(color: const Color(0xff49ADF3)))
                      : const BoxDecoration(),
                  child: Stack(
                    children: [
                      Image.file(
                        imageList[index].image!,
                        width: imageList[index].size,
                        height: imageList[index].size,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            imageList[index].isEdit!
                ? Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        imageList.removeAt(index);
                        setState(() {});
                      },
                      child: CircleAvatar(
                          radius: 12,
                          backgroundColor:
                              const Color(0xff1E4355).withOpacity(0.5),
                          child: const Icon(
                            Icons.close,
                            size: 20,
                          )),
                    ),
                  )
                : Container(),
            imageList[index].isEdit!
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        for (var e in widgetJson) {
                          e.isEdit = false;
                        }
                        for (var e in imageList) {
                          e.isEdit = false;
                        }

                        imageList[index].isEdit = true;
                        setState(() {
                          imageList[index].size =
                              imageList[index].size! + details.delta.dy;
                        });
                      },
                      child: CircleAvatar(
                          radius: 12,
                          backgroundColor:
                              const Color(0xff1E4355).withOpacity(0.5),
                          child: Icon(
                            Icons.open_in_full,
                            color: kWhiteColor,
                            size: 20,
                          )),
                    ),
                  )
                : Container()
          ],
        ));
  }

  ListView openMainMenuWidget(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            b.BottomBarContainer(
              imageIcon: "images/newIcons/crop 1.png",
              onTap: () {
                cropImage(_image!).then((value) {
                  _image = value;
                  setState(() {});
                });
              },
              title: 'Crop',
            ),
            b.BottomBarContainer(
              imageIcon: "images/newIcons/text-formatting 1.png",
              onTap: () {
                openTextField = true;
                setState(() {});
              },
              title: 'Add Text',
            ),
            b.BottomBarContainer(
              imageIcon: "images/newIcons/text (1) 1.png",
              onTap: () {
                if (widgetJson.isEmpty) {
                  Get.snackbar('Wrong', 'Please add text.',
                      colorText: Colors.white, backgroundColor: Colors.black);
                  return;
                }

                openFonts = true;

                setState(() {});
              },
              title: 'Styles',
            ),
            b.BottomBarContainer(
              imageIcon: "images/newIcons/image.png",
              onTap: () {
                selectImage();
              },
              title: 'Add Image',
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            b.BottomBarContainer(
              imageIcon: "images/newIcons/adjust 1.png",
              onTap: () {
                openFrames = true;
                setState(() {});
              },
              title: 'Frames',
            ),
            b.BottomBarContainer(
              imageIcon: "images/newIcons/magic-tool (1) 1.png",
              title: 'Effects',
              onTap: () async {
                openFilter = true;
                setState(() {});
              },
            ),
            b.BottomBarContainer(
              imageIcon: "images/newIcons/flip 1.png",
              onTap: () {
                setState(() {
                  flipValue = flipValue == 0 ? math.pi : 0;
                });
              },
              title: 'Flip',
            ),
            b.BottomBarContainer(
              imageIcon: "images/newIcons/rotation (2) 1.png",
              onTap: () {
                openRotation = true;
                setState(() {});
              },
              title: 'Rotation',
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            b.BottomBarContainer(
              imageIcon: "images/newIcons/sticker (1) 1.png",
              onTap: () {
                openStickers = true;
                setState(() {});
              },
              title: 'Sticker',
            ),
            b.BottomBarContainer(
              imageIcon: "images/hearts.png",
              onTap: () {
                Get.bottomSheet(SizedBox(
                  width: double.infinity,
                  height: Get.width * 0.8,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      TextModel m = TextModel(
                        name: emoji.emoji,
                        color: kWhiteColor,
                        size: 50.0,
                        align: TextAlign.center,
                        isEdit: true,
                        type: 1,
                        myFontModel: FontModel(
                          Colors.transparent,
                          isUseCurved: false,
                          isBackgroundContained: false,
                          textStyle: const TextStyle(),
                          textFontSize: 15.0,
                          textFontWidth: 30.0,
                          textFontHeight: 20.0,
                          textColor: kBlackColor,
                          textShadow: const Shadow(),
                          textBackgroundBorderSize: 1.0,
                          textBackgroundColor: kWhiteColor,
                          textBackgroundOpacity: 1.0,
                          textBorderOpacity: 1.0,
                          textBorderRadius: 0.0,
                          textOpacity: 1.0,
                        ),
                      );
                      widgetJson.add(m);
                      offsets.add(Offset.zero);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    onBackspacePressed: () {},
                    config: Config(
                      columns: 7,
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      // Issue: https://github.com/flutter/flutter/issues/28894
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      bgColor: Colors.white,
                      indicatorColor: Colors.blue,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.blue,
                      progressIndicatorColor: Colors.blue,
                      backspaceColor: Colors.blue,
                      skinToneDialogBgColor: Colors.white,
                      skinToneIndicatorColor: Colors.grey,
                      enableSkinTones: true,
                      showRecentsTab: true,
                      recentsLimit: 28,
                      noRecents: const Text(
                        'No Recent',
                        style: TextStyle(fontSize: 20, color: Colors.black26),
                        textAlign: TextAlign.center,
                      ),
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL,
                    ),
                  ),
                ));
              },
              title: 'Emoji',
            ),
            b.BottomBarContainer(
              imageIcon: "images/newIcons/blur 1.png",
              onTap: () {
                ///todo: i've commented
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setS) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          height: 400,
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
                                          imageThemes[selectedElement]
                                              .largeImage),
                                      fit: BoxFit.fill)),

                          child: Column(
                            children: [
                              Text(
                                'Slider Filter Color'.toUpperCase(),
                                style: TextStyle(color: kWhiteColor),
                                textAlign: TextAlign.center,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Slider Color'.toUpperCase(),
                                style: TextStyle(color: kWhiteColor),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: EditedFastColorPicker(
                                      selectedColor: colorValue,
                                      onColorSelected: (color) {
                                        setS(() {
                                          setState(() {
                                            colorValue = color;
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Slider Opacity'.toUpperCase(),
                                style: TextStyle(color: kWhiteColor),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Slider(
                                          activeColor: kWhiteColor,
                                          inactiveColor: Colors.grey,
                                          value: opacityValue,
                                          min: 0.00,
                                          max: 1.0,
                                          onChanged: (v) {
                                            setS(() {
                                              setState(() {
                                                opacityValue = v;
                                              });
                                            });
                                          })),
                                  TextButton(
                                    onPressed: () {
                                      setS(() {
                                        setState(() {
                                          opacityValue = 0.0;
                                        });
                                      });
                                    },
                                    child: const Text('Reset'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              title: 'Blur',
            ),
          ],
        ),
      ],
    );
  }

  selectImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageList.add(ImageModelEditing(
          image: File(pickedImage.path), size: 100, top: 50, left: 50));
      setState(() {});
    }
  }

  final picker = ImagePicker();

  showFramesWidget() {
    return openFramesWidget(
        framesOnTap: (int i, String frame) {
          setState(() {
            if (i == 0) {
              currentFrame = null;
            } else {
              currentFrame = frame;
            }
          });
        },
        onTap: () {
          setState(() {
            openFrames = false;
          });
        },
        title: getTitle());
  }

  showStickersWidget() {
    return openStickersWidget(
        title: getTitle(),
        onSelected: () {
          isStickerTrue = true;

          offsets.add(Offset.zero);

          setState(() {});
        },
        // scrollControllerForYou: _scrollControllerForYou,
        onBack: () {
          setState(() {
            openStickers = false;
          });
        });
  }

  showOpenFontFamilyWidget() {
    return openFontFamilyWidget(
        onBack: () {
          setState(() {
            openFonts = true;
            openFontFamily = false;
          });
        },
        title: getTitle(),
        onPress: () {
          setState(() {});
        });
  }

  showOpenResizeWidget() {
    return openResizeWidget(
        textFontSize: textFontSize,
        onBack: () {
          openFonts = true;
          openResize = false;
          setState(() {});
        },
        title: getTitle(),
        onUpdate: () {
          setState(() {});
        },
        onTap: (newValue) {
          textFontSize = newValue;

          setState(() {});
        });
  }

  showOpenTextColorWidget() {
    return openTextColorWidget(context,
        onBack: () {
          setState(() {
            openFonts = true;
            openTextColor = false;
          });
        },
        title: getTitle(),
        pickerColor: pickerColor,
        changeColor: (c) => changeColor(c),
        colorPicker: myColorPicker(),
        gotIt: () {
          changeColorBlock(pickerColor);
          setState(() => currentColor = pickerColor);
          Navigator.of(context).pop();
        });
  }

  showOpenFontsWidget() {
    return openFontsWidget(
        onBack: () {
          setState(() {
            openFonts = false;
            openTextField = false;
          });
        },
        title: getTitle(),
        onBgs: () {
          openFonts = false;
          openBackgroundColor = true;
          setState(() {});
        },
        onCurveText: () {
          openFonts = false;
          openCurveText = true;
          setState(() {});
        },
        onFonts: () {
          openFonts = false;
          openFontFamily = true;
          setState(() {});
        },
        onFormat: () {
          openFonts = false;
          openTextFormat = true;
          setState(() {});
        },
        onOpacity: () {
          openFonts = false;
          openTextOpacity = true;
          setState(() {});
        },
        onResize: () {
          openFonts = false;
          openResize = true;
          setState(() {});
        },
        onShadow: () {
          openFonts = false;
          openShadow = true;
          setState(() {});
        },
        onTextColor: () {
          openFonts = false;
          openTextColor = true;
          setState(() {});
        },
        onUpdate: () {
          setState(() {});
        });
  }

  showOpenShadowWidget() {
    return openShadowWidget(
      context,
      showBlurRadius: showBlurRadius,
      onShowBlurRadius: (newValue) {
        showBlurRadius = newValue;
        setState(() {});
      },
      shadowColor: shadowColor,
      xAxisShadow: xAxisShadow,
      yAxisShadow: yAxisShadow,
      onYAxisShadowChange: (newValue) {
        yAxisShadow = newValue;
        setState(() {});
      },
      onXAxisShadowChange: (newValue) {
        xAxisShadow = newValue;
        setState(() {});
      },
      onShadowColorChanged: (Color color) {
        shadowColor = color;

        setState(() {});
      },
      gotItFunction: () {
        setState(() {});

        Navigator.of(context).pop();
      },
      pickerColor: pickerColor,
      onColorChange: (Color color) {
        pickerColor = color;
        setState(() {});
      },
      onBac: () {
        setState(() {
          openFonts = true;
          openShadow = false;
        });
      },
      title: getTitle(),
    );
  }

  showBackgroundColorWidget() {
    return openBackgroundColorWidget(
      context,
      updateBorderTextSize: (newValue) {
        textBorderSize = newValue;
      },
      onShadowColor: (color) {
        shadowColor = color;
      },
      onTextBorderOpacity: (newValue) {
        textBorderOpacity = newValue;
      },
      onTextBackgroundOpacity: (newValue) {
        textBackgroundOpacity = newValue;
      },
      onBack: () {
        setState(() {
          openFonts = true;
          openBackgroundColor = false;
        });
      },
      onUpdate: () {
        setState(() {});
      },
      gotIt: () {
        changeColorBlock(pickerColor);
        setState(() => currentColor = pickerColor);
        Navigator.of(context).pop();
      },
      textBorderSize: textBorderSize,
      shadowColor: shadowColor,
      textBorderOpacity: textBorderOpacity,
      textBorderRadius: textBorderRadius,
      pickerColor: pickerColor,
      textBackgroundOpacity: textBackgroundOpacity,
      title: getTitle(),
    );
  }

  showOpenTextFormatWidget() {
    return openTextFormatWidget(
        onBack: () {
          setState(() {
            openFonts = true;
            openTextFormat = false;
          });
        },
        title: getTitle(),
        onUpdate: () {
          setState(() {});
        });
  }

  showTextWidgetForTyping() {
    return textWidgetForTyping(
      openTextField: openTextField,
      onRemoved: () {
        name.clear();
        openTextField = !openTextField;
        setState(() {});
      },
      isColors: isColors,
      name: name,
      onUpdate: () {
        setState(() {});
      },
      onSubmit: (selectedIndex, text) {
        for (var element in widgetJson) {
          element.isEdit = false;
        }

        if (isEdit) {
          isEdit = false;
          widgetJson[selectedIndex] = text;
          widgetJson[selectedIndex].isEdit = true;
        } else {
          widgetJson.add(text);
        }

        name.clear();
        openTextField = false;
        offsets.add(Offset.zero);

        setState(() {});
      },
      isEdit: isEdit,
      currentColor: currentColor,
    );
  }

  showOpenTextOpacityWidget() {
    return openTextOpacityWidget(
        textOpacity: textOpacity,
        onBack: () {
          setState(() {
            openFonts = true;
            openTextOpacity = false;
          });
        },
        title: getTitle(),
        onUpdate: (newValue) {
          textOpacity = newValue;
          setState(() {});
        });
  }

  showOpenCurveTextWidget() {
    return openCurveTextWidget(
      onCurveAngle: (newValue) {
        curveAngle = newValue;
        setState(() {});
      },
      onBac: () {
        openFonts = true;
        openCurveText = false;
        setState(() {});
      },
      title: getTitle(),
      onCurveText: (a) {
        isCurved = a;
        setState(() {});
      },
      onCurveRadius: (newValue) {
        curveRadius = newValue;
        setState(() {});
      },
      isCurvedText: isCurved,
      curveRadius: curveRadius,
      curveAngle: curveAngle,
    );
  }

  showOpenRotationWidget() {
    return openRotationWidget(
        onSliderChange: (newValue) {
          setState(() {
            imageAngle = newValue;
          });
        },
        onBack: () {
          openRotation = false;
          setState(() {});
        },
        onDecrement: () {
          setState(() {
            rotateValue--;
          });
        },
        onIncrement: () {
          setState(() {
            rotateValue++;
          });
        },
        title: getTitle());
  }

  showOpenFilterWidget() {
    return openFiltersWidget(
        image: _image,
        onBack: () {
          openFilter = false;
          setState(() {});
        },
        onTap: (int index) {
          currentFilter = index;
          setState(() {});
        });
  }

  buildStickerWidget(f) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: f.value.size,
            width: f.value.size,
            decoration: BoxDecoration(
              border: f.value.isEdit!
                  ? Border.all(
                      width: 1,
                      color: const Color(0xff1E4355).withOpacity(0.5),
                    )
                  : Border.all(color: Colors.transparent),
              // image: DecorationImage(
              //   image: NetworkImage(f.value.name!),
              // ),
            ),
          ),
        ),
        Transform.rotate(
          angle: f.value.myFontModel!.curveAngle!,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: f.value.size,
              width: f.value.size,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(f.value.name!),
                ),
              ),
            ),
          ),
        ),
        f.value.isEdit!
            ? Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    widgetJson.removeAt(f.key);
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: const Color(0xff1E4355).withOpacity(0.5),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        f.value.isEdit!
            ? Positioned(
                top: 0,
                left: 0,
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return GestureDetector(
                      // behavior: HitTestBehavior.translucent,

                      onPanUpdate: (details) {
                        if (kDebugMode) {
                          print("The Angle is ${details.delta.dx}");
                        }

                        try {
                          Offset centerOfGestureDetector = Offset(
                              constraints.maxWidth / 2,
                              constraints.maxHeight / 2);
                          final touchPositionFromCenter =
                              details.localPosition - centerOfGestureDetector;
                          setState(
                            () {
                              f.value.myFontModel?.curveAngle =
                                  touchPositionFromCenter.direction -
                                      offsetAngle;
                            },
                          );
                        } catch (e) {
                          if (kDebugMode) {
                            print(" $e ");
                          }
                        }
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: const Color(0xff1E4355).withOpacity(0.5),
                        child: const Icon(
                          Icons.rotate_right,
                          size: 20,
                        ),
                      ),
                    );
                  }),
                ),
              )
            : const SizedBox(),
        f.value.isEdit!
            ? Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanUpdate: (details) {
                        TextModel m =
                            widgetJson.firstWhere((element) => element.isEdit!);
                        int index = widgetJson.indexOf(m);
                        widgetJson[index].size =
                            widgetJson[index].size! + details.delta.dy;
                        // imageHeight =
                        //     widgetJson[index].size! + details.delta.dy;

                        setState(() {});
                      },
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: const Color(0xff1E4355).withOpacity(0.5),
                        child: const Icon(
                          Icons.open_in_full,
                          size: 20,
                        ),
                      ),
                    );
                  }),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
