import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editor/models/sticker_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/theme.dart';
import '../widgets/textStyle.dart';
import 'Editor/image_editor_pro.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({Key? key}) : super(key: key);

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  final List<Color> myColorList = [
    Colors.red,
    Colors.green,
    Colors.black,
    Colors.amberAccent,
    Colors.orangeAccent,
    Colors.redAccent,
    Colors.cyanAccent,
    Colors.indigoAccent,
    Colors.deepOrangeAccent,
    Colors.tealAccent,
    Colors.blueGrey,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 10, left: 5, bottom: 10),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                        icon: Icon(Icons.arrow_back, color: kWhiteColor),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Center(
                        child: Text(
                          'Background'.tr,
                          style: myTextStyle(18, FontWeight.w600, kWhiteColor),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('backgrounds')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return SizedBox(
                              width: double.infinity,
                              height: Get.height * 0.6,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            );
                          }

                          final data = snapshot.data!.docs;

                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: GridView.builder(
                                itemCount: data.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.65,
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8),
                                itemBuilder: (ctx, i) {
                                  BackgroundModel bg =
                                      BackgroundModel.fromJson(data[i].data());

                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => ImageEditorPro(
                                            backgroundImagePath: bg.image!,
                                          ));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Image.network(
                                        bg.image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }),
                          );
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
