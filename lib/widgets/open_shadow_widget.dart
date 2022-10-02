import 'package:editor/widgets/sliderWidget.dart';
import 'package:editor/widgets/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:math' as math;

import '../fast_color_picker/color_picker.dart';
import '../models/text_model.dart';
import '../utils/app_colors.dart';
import '../views/Editor/image_editor_pro.dart';

SingleChildScrollView openShadowWidget(context,{Function? onBac,Widget? title,Color? pickerColor,Function? onColorChange,Function? gotItFunction,Color? shadowColor,Function? onShadowColorChanged,Function? onXAxisShadowChange,double? xAxisShadow,double? yAxisShadow,Function? onYAxisShadowChange,double? showBlurRadius,Function? onShowBlurRadius}) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:const  EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  onBac!();
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
                              onColorChanged: (Color color) => onColorChange!(color),
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Got it'),
                              onPressed: () {
                                TextModel currentJsonWidget =
                                widgetJson.firstWhere((element) =>
                                element.isEdit == true);

                                int currentJsonIndex =
                                widgetJson.indexOf(currentJsonWidget);

                                widgetJson[currentJsonIndex]
                                    .myFontModel!
                                    .textShadow =
                                    Shadow(
                                        blurRadius: currentJsonWidget
                                            .myFontModel!
                                            .textShadow!
                                            .blurRadius,
                                        offset: Offset(
                                            currentJsonWidget.myFontModel!
                                                .textShadow!.offset.dx,
                                            currentJsonWidget.myFontModel!
                                                .textShadow!.offset.dy),
                                        color: pickerColor);

                                gotItFunction!();
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  width: 28,
                  height: 28,
                  padding: const EdgeInsets.all(4),
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

            widgetJson[currentJsonIndex].myFontModel!.textShadow = Shadow(
                blurRadius:
                currentJsonWidget.myFontModel!.textShadow!.blurRadius,
                offset: Offset(
                    currentJsonWidget.myFontModel!.textShadow!.offset.dx,
                    currentJsonWidget.myFontModel!.textShadow!.offset.dy),
                color: color);

            onShadowColorChanged!(color);
          },
        ),
        Container(
          padding:const  EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'x - axis:',
                      style: myTextStyle(14, FontWeight.w400, kWhiteColor),
                    ),
                  ),
                  Expanded(
                      flex: 14,
                      child: sliderWidget(
                        -100,
                        100,
                        200,
                        xAxisShadow!,
                            (double newValue) {
                          TextModel currentJsonWidget =
                          widgetJson.firstWhere(
                                  (element) => element.isEdit == true);
                          int currentIndex =
                          widgetJson.indexOf(currentJsonWidget);

                          widgetJson[currentIndex].myFontModel!.textShadow =
                              Shadow(
                                  blurRadius:
                                  currentJsonWidget.myFontModel!
                                      .textShadow!.blurRadius,
                                  offset: Offset(
                                      newValue,
                                      currentJsonWidget.myFontModel!
                                          .textShadow!.offset.dy),
                                  color: currentJsonWidget
                                      .myFontModel!.textShadow!.color);


                          onXAxisShadowChange!(newValue);

                        },
                      )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'y - axis:',
                      style: myTextStyle(14, FontWeight.w400, kWhiteColor),
                    ),
                  ),
                  Expanded(
                      flex: 14,
                      child: sliderWidget(
                        -100,
                        100,
                        200,
                        yAxisShadow!,
                            (double newValue) {
                          TextModel currentJsonWidget =
                          widgetJson.firstWhere(
                                  (element) => element.isEdit == true);
                          int currentIndex =
                          widgetJson.indexOf(currentJsonWidget);

                          widgetJson[currentIndex].myFontModel!.textShadow =
                              Shadow(
                                  blurRadius:
                                  currentJsonWidget.myFontModel!
                                      .textShadow!.blurRadius,
                                  offset: Offset(
                                      currentJsonWidget.myFontModel!
                                          .textShadow!.offset.dx,
                                      newValue),
                                  color: currentJsonWidget
                                      .myFontModel!.textShadow!.color);
                          onYAxisShadowChange!(newValue);
                        },
                      )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Blur radius:',
                      style: myTextStyle(14, FontWeight.w400, kWhiteColor),
                    ),
                  ),
                  Expanded(
                      flex: 14,
                      child: SliderTheme(
                        data:const SliderThemeData(
                          valueIndicatorColor: Color(0xffF932B5),
                        ),
                        child: Slider(
                            value: showBlurRadius!,
                            min: 0,
                            max: 1,
                            divisions: 50,
                            activeColor:const  Color(0xff71DECA),
                            thumbColor: Colors.white,
                            label: showBlurRadius.toStringAsFixed(1),
                            inactiveColor:
                            const Color(0xffFFFCFF).withOpacity(0.2),
                            onChanged: (double newValue) {
                              TextModel currentJsonWidget =
                              widgetJson.firstWhere(
                                      (element) => element.isEdit == true);
                              int currentIndex =
                              widgetJson.indexOf(currentJsonWidget);

                              widgetJson[
                              currentIndex]
                                  .myFontModel!
                                  .textShadow =
                                  Shadow(
                                      blurRadius: newValue,
                                      offset: Offset(
                                          currentJsonWidget.myFontModel!
                                              .textShadow!.offset.dx,
                                          currentJsonWidget.myFontModel!
                                              .textShadow!.offset.dy),
                                      color: currentJsonWidget
                                          .myFontModel!.textShadow!.color);


                              onShowBlurRadius!(newValue);
                            }),
                      ))
                ],
              ),
            ],
          ),
        ),
      ],
    )
  );
}
