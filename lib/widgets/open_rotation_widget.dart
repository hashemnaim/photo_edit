import 'package:editor/widgets/sliderWidget.dart';
import 'package:editor/widgets/textStyle.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


import '../utils/app_colors.dart';
import '../views/Editor/bottomBarContainer.dart';
import '../views/Editor/image_editor_pro.dart';

openRotationWidget({required Function onBack,required Widget title,required Function onIncrement,required Function onDecrement,required Function onSliderChange}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding:const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                onBack();
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
            Container(
              width: 30,
            )
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          BottomBarContainer(
            imageIcon: "images/rotation.png",
            onTap: () {
              onDecrement();
            },
            title: 'Rotate left',
          ),
          BottomBarContainer(
            imageIcon: "images/rotation.png",
            onTap: () {
              onIncrement();
            },
            title: 'Rotate right',
          ),
        ],
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
              top: 5,
            ),
            child: Text(
              'Rotate Image',
              style: myTextStyle(16, FontWeight.bold, kWhiteColor),
            ),
          ),
          Expanded(
              child: sliderWidget(0.0, 6.5, 100, imageAngle,
                      (double newValue) {
                    onSliderChange(newValue);
                  })),
        ],
      ),
    ],
  );
}
