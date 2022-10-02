import 'package:editor/widgets/sliderWidget.dart';
import 'package:editor/widgets/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:math' as math;

import '../fast_color_picker/color_picker.dart';
import '../models/text_model.dart';
import '../utils/app_colors.dart';
import '../views/Editor/image_editor_pro.dart';


openBackgroundColorWidget(context,{required Function? onBack,required Widget? title,required Color? pickerColor,required Function? gotIt,required Color? shadowColor,required Function? onUpdate,required double? textBorderRadius,required double? textBorderSize,required double? textBackgroundOpacity,required double? textBorderOpacity,required Function updateBorderTextSize,required Function onTextBackgroundOpacity,required Function onTextBorderOpacity,required Function onShadowColor}) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
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
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: pickerColor!,
                              onColorChanged: (Color color) {
                                TextModel currentJsonWidget =
                                widgetJson.firstWhere(
                                        (element) => element.isEdit == true);

                                int currentJsonIndex =
                                widgetJson.indexOf(currentJsonWidget);

                                widgetJson[currentJsonIndex]
                                    .myFontModel!
                                    .isBackgroundContained = true;
                                widgetJson[currentJsonIndex]
                                    .myFontModel!
                                    .textBackgroundColor = color;
                               onUpdate!();
                              },
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Got it'),
                              onPressed: () {
                               gotIt!();
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  width: 28,
                  height: 28,
                  padding:const EdgeInsets.all(4),
                  child:
                  Image.asset('images/newIcons/color-picker (1) 1.png'),
                  decoration: BoxDecoration(
                      border:
                      Border.all(color:const Color(0xff71DECAC9), width: 2),
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ],
          ),
        ),
       const SizedBox(
          height: 8,
        ),
        FastColorPickers(
          selectedColor: shadowColor,
          onColorSelected: (color) {
            TextModel currentJsonWidget =
            widgetJson.firstWhere((element) => element.isEdit == true);

            int currentJsonIndex = widgetJson.indexOf(currentJsonWidget);

            widgetJson[currentJsonIndex].myFontModel!.isBackgroundContained =
            true;

            shadowColor = color;
           widgetJson[currentJsonIndex]
                .myFontModel!
                .textBackgroundColor = color;
           onUpdate!();
          },
        ),
        Container(
          padding:const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: Text(
                      'Border Radius:',
                      style: myTextStyle(14, FontWeight.w400, kWhiteColor),
                    ),
                  ),
                  Flexible(
                      flex: 14,
                      fit: FlexFit.tight,
                      child: sliderWidget(
                        0,
                        100,
                        100,
                        textBorderRadius!,
                            (double newValue) {
                          TextModel currentJsonWidget = widgetJson.firstWhere(
                                  (element) => element.isEdit == true);
                          int currentIndex =
                          widgetJson.indexOf(currentJsonWidget);

                          widgetJson[currentIndex]
                              .myFontModel!
                              .textBorderRadius = newValue;
                          textBorderRadius = newValue;
                          onUpdate!();
                        },
                      )),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: Text(
                      'Border Size:',
                      style: myTextStyle(14, FontWeight.w400, kWhiteColor),
                    ),
                  ),
                  Flexible(
                    flex: 14,
                    fit: FlexFit.tight,
                    child: sliderWidget(0, 10, 100, textBorderSize!,
                            (double newValue) {
                          TextModel currentJsonWidget = widgetJson
                              .firstWhere((element) => element.isEdit == true);

                          int currentIndex =
                          widgetJson.indexOf(currentJsonWidget);

                          widgetJson[currentIndex]
                              .myFontModel!
                              .textBackgroundBorderSize = newValue;
                          textBorderSize = newValue;
                          updateBorderTextSize(newValue);
                          onUpdate!();
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: Text(
                      'Opacity:',
                      style: myTextStyle(14, FontWeight.w400, kWhiteColor),
                    ),
                  ),
                  Flexible(
                      flex: 14,
                      fit: FlexFit.tight,
                      child: SliderTheme(
                        data:const SliderThemeData(
                          valueIndicatorColor: Color(0xffF932B5),
                          trackHeight: 2,
                        ),
                        child: Slider(
                            value: textBackgroundOpacity!,
                            min: 0,
                            max: 1,
                            divisions: 50,
                            activeColor:const Color(0xff71DECA),
                            thumbColor: Colors.white,
                            label:
                            textBackgroundOpacity.toStringAsFixed(1),
                            inactiveColor:const Color(0xffFFFCFF).withOpacity(0.2),
                            onChanged: (double newValue) {
                              TextModel currentJsonWidget =
                              widgetJson.firstWhere(
                                      (element) => element.isEdit == true);

                              int currentJsonIndex =
                              widgetJson.indexOf(currentJsonWidget);
                              widgetJson[currentJsonIndex]
                                  .myFontModel!
                                  .textBackgroundOpacity = newValue;
                              textBackgroundOpacity = newValue;
                              onTextBackgroundOpacity(newValue);
                              onUpdate!();
                            }),
                      ))
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: Text(
                      'Border Opacity:',
                      style: myTextStyle(14, FontWeight.w400, kWhiteColor),
                    ),
                  ),
                  Flexible(
                    flex: 14,
                    fit: FlexFit.tight,
                    child: SliderTheme(
                      data: const SliderThemeData(
                        valueIndicatorColor: Color(0xffF932B5),
                        trackHeight: 2,
                      ),
                      child: Slider(
                        value: textBorderOpacity!,
                        min: 0,
                        max: 1,
                        activeColor:const Color(0xff71DECA),
                        thumbColor: Colors.white,
                        label: textBorderOpacity.toStringAsFixed(1),
                        inactiveColor: const Color(0xffFFFCFF).withOpacity(0.2),
                        onChanged: (double newValue) {
                          TextModel currentJsonWidget = widgetJson.firstWhere(
                                  (element) => element.isEdit == true);
                          int currentJsonIndex =
                          widgetJson.indexOf(currentJsonWidget);
                          widgetJson[currentJsonIndex]
                              .myFontModel!
                              .textBorderOpacity = newValue;
                          textBorderOpacity = newValue;
                          onTextBorderOpacity(newValue);
                          onUpdate!();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        FastColorPickers(
          selectedColor: shadowColor,
          onColorSelected: (color) {
            TextModel currentJsonWidget =
            widgetJson.firstWhere((element) => element.isEdit == true);

            int currentJsonIndex = widgetJson.indexOf(currentJsonWidget);

            shadowColor = color;
            widgetJson[currentJsonIndex]
                .myFontModel!
                .backgroundBorderColor = color;
            onShadowColor(color);
            onUpdate!();
          },
        ),
      ],
    ),
  );
}
