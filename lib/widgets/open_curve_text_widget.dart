import 'package:editor/widgets/sliderWidget.dart';
import 'package:editor/widgets/textStyle.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../models/text_model.dart';
import '../utils/app_colors.dart';
import '../views/Editor/image_editor_pro.dart';

openCurveTextWidget({required Function onBac,required Widget title,required bool isCurvedText,required Function onCurveText,required double curveRadius,required Function onCurveRadius,required double curveAngle,required Function onCurveAngle}) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  onBac();
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
              title,
              Container()
            ],
          ),
        ),
        Container(
          padding:const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Curve Text",
                      style: myTextStyle(14, FontWeight.bold, kWhiteColor),
                    ),
                  ),
                  Switch(
                      value: isCurvedText,
                      onChanged: (a) {
                        isCurvedText = a;
                        TextModel currentJsonWidget = widgetJson.firstWhere(
                                (element) => element.isEdit == true);

                        int currentIndex =
                        widgetJson.indexOf(currentJsonWidget);

                        widgetJson[currentIndex].myFontModel!.isUseCurved =
                            isCurvedText;

                        onCurveText(a);
                      }),
                ],
              ),
              !isCurvedText
                  ? Container()
                  : Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Curve Radius:',
                      style: myTextStyle(
                          14, FontWeight.bold, kWhiteColor),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: sliderWidget(
                      20,
                      180,
                      160,
                      curveRadius,
                          (double newValue) {
                        TextModel currentJsonWidget =
                        widgetJson.firstWhere(
                                (element) => element.isEdit == true);

                        int currentIndex =
                        widgetJson.indexOf(currentJsonWidget);

                        widgetJson[currentIndex]
                            .myFontModel!
                            .curveRadius = newValue;
                        onCurveRadius(newValue);
                      },
                    ),
                  ),
                ],
              ),
              !isCurvedText
                  ? Container()
                  : Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Curve Angle:',
                      style: myTextStyle(
                          14, FontWeight.bold, kWhiteColor),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: sliderWidget(0.0, 360, 360, curveAngle,
                            (double newValue) {
                          TextModel currentJsonWidget =
                          widgetJson.firstWhere(
                                  (element) => element.isEdit == true);

                          int currentIndex =
                          widgetJson.indexOf(currentJsonWidget);
                          widgetJson[currentIndex]
                              .myFontModel!
                              .curveAngle = newValue;
                          onCurveAngle(newValue);
                        }),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
