import 'package:editor/widgets/textStyle.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../models/text_model.dart';
import '../utils/app_colors.dart';
import '../views/Editor/image_editor_pro.dart';

openTextFormatWidget({Function? onBack, Widget? title,Function? onUpdate}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              onBack!();
            },
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
          Container(
            width: 30,
          ),
        ],
      ),
    const  Spacer(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              TextModel currentJsonWidget = widgetJson
                  .firstWhere((element) => element.isEdit == true);
              int currentJsonIndex = widgetJson.indexOf(currentJsonWidget);
              widgetJson[currentJsonIndex].myFontModel!.myAlignment =
                  TextAlign.left;
              onUpdate!();
            },
            child: Column(
              children: [
                SizedBox(
                    width: 22,
                    height: 22,
                    child: Image.asset(
                        'images/newIcons/left-align (4) 1.png')),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Left',
                  style: myTextStyle(16, FontWeight.normal, kWhiteColor),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              TextModel currentJsonWidget = widgetJson
                  .firstWhere((element) => element.isEdit == true);

              int currentJsonIndex = widgetJson.indexOf(currentJsonWidget);
              widgetJson[currentJsonIndex].myFontModel!.myAlignment =
                  TextAlign.center;

              onUpdate!();
            },
            child: Column(
              children: [
                SizedBox(
                    width: 22,
                    height: 22,
                    child: Image.asset(
                        'images/newIcons/center-align (3) 1.png')),
               const SizedBox(
                  height: 5,
                ),
                Text(
                  'Center',
                  style: myTextStyle(16, FontWeight.normal, kWhiteColor),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              TextModel currentJsonWidget = widgetJson
                  .firstWhere((element) => element.isEdit == true);

              int currentJsonIndex = widgetJson.indexOf(currentJsonWidget);
              widgetJson[currentJsonIndex].myFontModel!.myAlignment =
                  TextAlign.right;

              onUpdate!();
            },
            child: Column(
              children: [
                SizedBox(
                    width: 22,
                    height: 22,
                    child: Image.asset(
                        'images/newIcons/left-align (5) 1.png')),
               const SizedBox(
                  height: 5,
                ),
                Text(
                  'Right',
                  style: myTextStyle(16, FontWeight.normal, kWhiteColor),
                )
              ],
            ),
          ),
        ],
      ),
      const Spacer(),
    ],
  );
}

