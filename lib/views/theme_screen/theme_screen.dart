import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_colors.dart';
import '../../utils/theme.dart';
import '../../widgets/textStyle.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  late SharedPreferences prefs;

  getPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  updatePreferences(bool isColor, int index, {bool isDarkColor = false}) {
    isColors = isColor;
    isDark = isDarkColor;

    if (isDark) {
      kWhiteColor = Colors.white;
    } else {
      kWhiteColor = Colors.black;
    }
    selectedElement = index;

    if (!isColors) {
      kWhiteColor = imageThemes[index].color;
    }
    prefs.setBool('isColor', isColor);
    prefs.setBool('isDark', isDark);

    prefs.setInt('element', index);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: AppBar().preferredSize.height,
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back, color: kWhiteColor),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          'Theme',
                          style: myTextStyle(18, FontWeight.w600, kWhiteColor),
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container())
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Light Colors',
                  style: myTextStyle(18, FontWeight.w600, kWhiteColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: Get.width,
                  height: 50,
                  child: ListView.builder(
                      itemCount: lightColors.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap: () {
                            updatePreferences(true, i, isDarkColor: false);
                          },
                          child: Container(
                            width: 50,
                            height: 40,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: isColors &&
                                            !isDark &&
                                            selectedElement == i
                                        ? kWhiteColor
                                        : Colors.transparent),
                                gradient: LinearGradient(
                                    colors: lightColors[i],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Dark Colors',
                  style: myTextStyle(18, FontWeight.w600, kWhiteColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: Get.width,
                  height: 50,
                  child: ListView.builder(
                      itemCount: darkColors.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap: () {
                            updatePreferences(true, i, isDarkColor: true);
                          },
                          child: Container(
                            width: 50,
                            height: 40,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: isColors &&
                                            isDark &&
                                            selectedElement == i
                                        ? kWhiteColor
                                        : Colors.transparent),
                                gradient: LinearGradient(
                                    colors: darkColors[i],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Wallpapers',
                  style: myTextStyle(18, FontWeight.w600, kWhiteColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  // color: Colors.yellow,
                  margin: const EdgeInsets.only(right: 5),
                  child: GridView.builder(
                      itemCount: imageThemes.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.65,
                              crossAxisCount: 3,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4),
                      itemBuilder: (ctx, i) {
                        return GestureDetector(
                            onTap: () {
                              updatePreferences(false, i, isDarkColor: true);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.asset(
                                imageThemes[i].largeImage,
                                fit: BoxFit.cover,
                              ),
                            ));
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
