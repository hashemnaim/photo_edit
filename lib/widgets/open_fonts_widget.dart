import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../models/text_model.dart';
import '../views/Editor/bottomBarContainer.dart' as b;
import '../views/Editor/image_editor_pro.dart';

openFontsWidget(
    {Function? onBack,
    Widget? title,
    Function? onFonts,
    Function? onTextColor,
    Function? onBgs,
    Function? onShadow,
    Function? onResize,
    Function? onCurveText,
    Function? onFormat,
    Function? onOpacity,
    Function? onUpdate}) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Row(
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
            Container(width: 30),
          ],
        ),
        const SizedBox(height: 11),
        Row(
          children: [
            b.BottomBarContainer(
              imageIcon: 'images/newIcons/font (1) 1.png',
              title: 'Fonts'.tr,
              onTap: () {
                onFonts!();
              },
            ),
            b.BottomBarContainer(
              imageIcon: 'images/newIcons/colour (1) 1.png',
              title: 'Text Color'.tr,
              onTap: () {
                onTextColor!();
              },
            ),
            b.BottomBarContainer(
              imageIcon: 'images/newIcons/background (3) 1.png',
              title: 'Background'.tr,
              onTap: () {
                onBgs!();
              },
            ),
            b.BottomBarContainer(
              imageIcon:
                  'images/newIcons/circle-and-cube-with-shadow (3) 1.png',
              title: 'Shadow'.tr,
              onTap: () {
                onShadow!();
              },
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            b.BottomBarContainer(
              imageIcon: 'images/newIcons/maximize (1) 1.png',
              title: 'Resize'.tr,
              onTap: () {
                onResize!();
              },
            ),

            b.BottomBarContainer(
              imageIcon: 'images/newIcons/corner (1) 1.png',
              title: 'Curve Text'.tr,
              onTap: () {
                onCurveText!();
              },
            ),

            ///d

            b.BottomBarContainer(
              imageIcon: 'images/newIcons/center-align (3) 1.png',
              title: 'Format'.tr,
              onTap: () {
                onFormat!();
              },
            ),
            b.BottomBarContainer(
              imageIcon: 'images/newIcons/coloring-tool 1.png',
              title: 'Opacity'.tr,
              onTap: () {
                onOpacity!();
              },
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            b.BottomBarContainer(
              imageIcon: 'images/newIcons/bold-text 1.png',
              title: 'Bold'.tr,
              onTap: () {
                TextModel selectedText =
                    widgetJson.firstWhere((element) => element.isEdit!);

                int index = widgetJson.indexOf(selectedText);

                if (selectedText.myFontModel!.fontWeight == FontWeight.normal) {
                  widgetJson[index].myFontModel!.fontWeight = FontWeight.bold;
                } else {
                  widgetJson[index].myFontModel!.fontWeight = FontWeight.normal;
                }

                onUpdate!();
              },
            ),
            b.BottomBarContainer(
              imageIcon: 'images/newIcons/italic (1) 1.png',
              title: 'Italic'.tr,
              onTap: () {
                TextModel selectedText =
                    widgetJson.firstWhere((element) => element.isEdit!);

                int index = widgetJson.indexOf(selectedText);

                if (selectedText.myFontModel!.fontStyle != FontStyle.italic) {
                  widgetJson[index].myFontModel!.fontStyle = FontStyle.italic;
                } else {
                  widgetJson[index].myFontModel!.fontStyle = FontStyle.normal;
                }

                onUpdate!();
              },
            ),
            b.BottomBarContainer(
              imageIcon: 'images/newIcons/italic (2) 1.png',
              title: 'Underline'.tr,
              onTap: () {
                TextModel selectedText =
                    widgetJson.firstWhere((element) => element.isEdit!);

                int index = widgetJson.indexOf(selectedText);

                if (selectedText.myFontModel!.textDecoration !=
                    TextDecoration.underline) {
                  widgetJson[index].myFontModel!.textDecoration =
                      TextDecoration.underline;
                } else {
                  widgetJson[index].myFontModel!.textDecoration =
                      TextDecoration.none;
                }

                onUpdate!();
              },
            ),
            b.BottomBarContainer(
              imageIcon: 'images/newIcons/strikethrough 1.png',
              title: 'Line Through'.tr,
              onTap: () {
                TextModel selectedText =
                    widgetJson.firstWhere((element) => element.isEdit!);

                int index = widgetJson.indexOf(selectedText);

                if (selectedText.myFontModel!.textDecoration !=
                    TextDecoration.lineThrough) {
                  widgetJson[index].myFontModel!.textDecoration =
                      TextDecoration.lineThrough;
                } else {
                  widgetJson[index].myFontModel!.textDecoration =
                      TextDecoration.none;
                }

                onUpdate!();
              },
            ),
          ],
        ),
      ],
    ),
  );
}
