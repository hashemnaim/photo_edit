import 'package:editor/widgets/textStyle.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../models/text_model.dart';
import '../utils/app_colors.dart';
import '../views/Editor/image_editor_pro.dart';

openTextOpacityWidget({required Function? onBack,required Widget? title, required double? textOpacity,required Function? onUpdate}) {
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
      const SizedBox(
        height: 8,
      ),
      Container(
        padding:const  EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(
                'Opacity:',
                style: myTextStyle(16, FontWeight.w400, kWhiteColor),
              ),
            ),
            Expanded(
                flex: 14,
                child: SliderTheme(
                  data:const  SliderThemeData(
                      valueIndicatorColor: Color(0xffF932B5),
                      trackHeight: 2),
                  child: Slider(
                    value: textOpacity!,
                    min: 0,
                    max: 1,
                    divisions: 10,
                    activeColor:const  Color(0xff71DECA),
                    thumbColor: Colors.white,
                    label: textOpacity.toStringAsFixed(1),
                    inactiveColor:const  Color(0xffFFFCFF).withOpacity(0.2),
                    onChanged: (double newValue) {
                      TextModel currentJsonWidget = widgetJson
                          .firstWhere((element) => element.isEdit == true);

                      int currentJsonIndex =
                      widgetJson.indexOf(currentJsonWidget);
                      widgetJson[currentJsonIndex]
                          .myFontModel!
                          .textOpacity = newValue;
                      onUpdate!(newValue);
                    },
                  ),
                )),
          ],
        ),
      ),
    ],
  );
}
