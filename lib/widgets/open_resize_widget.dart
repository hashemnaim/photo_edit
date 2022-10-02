import 'package:editor/widgets/sliderWidget.dart';
import 'package:editor/widgets/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/text_model.dart';
import '../utils/app_colors.dart';
import '../views/Editor/image_editor_pro.dart';
import 'dart:math' as math;

Container openResizeWidget({Function? onBack,Widget? title,Function? onTap,Function? onUpdate,double textFontSize = 0.0}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:const  EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => onBack!(),
                  child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: Image.asset(
                          'images/anim3.gif',
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
                title!,
                Container()
              ],
            ),
          ),
         const SizedBox(
            height: 8,
          ),
          Container(
            padding:const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Font Size:',
                        style: myTextStyle(14, FontWeight.w400, kWhiteColor),
                      ),
                    ),
                    Expanded(
                      flex: 14,
                      child: sliderWidget(1, 100, 100, textFontSize,
                              (double newValue) {
                            TextModel currentJsonWidget = widgetJson
                                .firstWhere((element) => element.isEdit == true);
                            int currentJsonIndex =
                            widgetJson.indexOf(currentJsonWidget);
                            widgetJson[currentJsonIndex]
                                .myFontModel!
                                .textFontSize = newValue;
                           onTap!(newValue);
                          }),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Width:',
                        style: myTextStyle(14, FontWeight.w400, kWhiteColor),
                      ),
                    ),
                    Expanded(
                        flex: 14,
                        child: sliderWidget(
                            10,
                            Get.width - 60,
                            (Get.width - 60).toInt(),
                            widgetJson[0].width!, (double newValue) {
                          TextModel currentJsonWidget = widgetJson.firstWhere(
                                  (element) => element.isEdit == true);
                          int currentJsonIndex =
                          widgetJson.indexOf(currentJsonWidget);
                          widgetJson[currentJsonIndex].width = newValue;
                          onUpdate!();
                        })),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'x - padding:',
                        style: myTextStyle(14, FontWeight.w400, kWhiteColor),
                      ),
                    ),
                    Expanded(
                        flex: 14,
                        child: sliderWidget(1, 100, 100,
                            widgetJson[0].myFontModel!.textFontWidth!,
                                (double newValue) {
                              TextModel currentJsonWidget = widgetJson.firstWhere(
                                      (element) => element.isEdit == true);
                              int currentJsonIndex =
                              widgetJson.indexOf(currentJsonWidget);
                              widgetJson[currentJsonIndex]
                                  .myFontModel!
                                  .textFontWidth = newValue;
                              onUpdate!();
                            })),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'y - padding:',
                        style: myTextStyle(14, FontWeight.w400, kWhiteColor),
                      ),
                    ),
                    Expanded(
                        flex: 14,
                        child: sliderWidget(1, 100, 100,
                            widgetJson[0].myFontModel!.textFontHeight!,
                                (double newValue) {
                              TextModel currentJsonWidget = widgetJson.firstWhere(
                                      (element) => element.isEdit == true);
                              int currentJsonIndex =
                              widgetJson.indexOf(currentJsonWidget);
                              widgetJson[currentJsonIndex]
                                  .myFontModel!
                                  .textFontHeight = newValue;
                              onUpdate!();
                            })),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
