import 'package:editor/widgets/textStyle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/font_model.dart';
import '../models/text_model.dart';
import '../utils/app_colors.dart';
import '../utils/theme.dart';
import '../views/Editor/image_editor_pro.dart';

textWidgetForTyping(
    {required bool openTextField,
    required bool isColors,
    required TextEditingController name,
    required Function onRemoved,
    required bool isEdit,
    required Color currentColor,
    required Function onSubmit,
    required Function onUpdate}) {
  return openTextField
      ? Align(
          alignment: Alignment.center,
          child: Container(
            width: Get.width,
            height: Get.height * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 21),
            // decoration: isColors
            //     ? BoxDecoration(
            //         gradient: LinearGradient(
            //             colors: isDark
            //                 ? darkColors[selectedElement]
            //                 : lightColors[selectedElement],
            //             end: Alignment.bottomRight,
            //             begin: Alignment.topLeft))
            //     : BoxDecoration(
            //         image: DecorationImage(
            //             image:
            //                 AssetImage(imageThemes[selectedElement].smallImage),
            //             fit: BoxFit.fill)),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        onRemoved();
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.clear,
                          color: kWhiteColor,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: kWhiteColor, width: 2),
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                    Text(
                      "Add Text".tr,
                      style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        int selectedIndex = -1;
                        TextModel text;
                        if (isEdit) {
                          TextModel m = widgetJson
                              .firstWhere((element) => element.isEdit!);

                          selectedIndex = widgetJson.indexOf(m);
                          m.name = name.text;
                          text = m;
                        } else {
                          text = TextModel(
                            name: name.text,
                            color: currentColor,
                            size: 12.0,
                            align: TextAlign.center,
                            isEdit: true,
                            type: 2,
                            myFontModel: FontModel(
                              Colors.transparent,
                              isUseCurved: false,
                              isBackgroundContained: false,
                              textStyle: const TextStyle(),
                              textFontSize: 15.0,
                              textFontWidth: 50.0,
                              textFontHeight: 40.0,
                              textColor: Colors.black,
                              textShadow: const Shadow(),
                              textBackgroundBorderSize: 0.0,
                              textBackgroundColor: kPrimaryColor,
                              textBackgroundOpacity: 0.1,
                              textBorderOpacity: 1.0,
                              textBorderRadius: 0.0,
                              textOpacity: 1.0,
                            ),
                          );
                        }

                        if (text.name == null || name.text.isEmpty) {
                          if (kDebugMode) {
                            print('text is empty'.tr);
                          }
                        } else {
                          onSubmit(selectedIndex, text);
                        }
                        onUpdate();
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.check,
                          color: kWhiteColor,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: kWhiteColor, width: 2),
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                TextField(
                  style: const TextStyle(color: kBlackColor),
                  decoration: InputDecoration(
                    hintText: 'Enter Text'.tr,
                    hintStyle: myTextStyle(
                        16, FontWeight.w200, kWhiteColor.withOpacity(0.5)),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kWhiteColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kWhiteColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                  controller: name,
                  autofocus: true,
                ),
                const Spacer(),
              ],
            ),
          ),
        )
      : const SizedBox();
}
