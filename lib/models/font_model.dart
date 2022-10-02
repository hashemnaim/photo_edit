import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FontModel {
  TextStyle? textStyle;
  double? textFontSize,
      textFontWidth,
      textFontHeight,
      textBorderRadius,
      textBorderOpacity,
      textOpacity,
      textBackgroundOpacity,
      textBackgroundBorderSize,
      curveRadius,
      curveAngle;
  Shadow? textShadow;
  Color? textColor, textBackgroundColor;
  TextAlign? myAlignment;
  FontWeight fontWeight;
  TextDecoration textDecoration;
  FontStyle fontStyle;
  bool? isBackgroundContained = false;
  bool? isUseCurved = false;
  Color backgroundBorderColor;

  FontModel(this.backgroundBorderColor,
      {this.isBackgroundContained,
      this.isUseCurved,
      this.textStyle,
      this.textFontSize,
      this.textFontWidth,
      this.textFontHeight,
      this.textShadow,
      this.textColor,
      this.textBackgroundBorderSize,
      this.textBackgroundColor,
      this.textBackgroundOpacity,
      this.textBorderOpacity,
      this.textBorderRadius,
      this.textOpacity,
      this.myAlignment = TextAlign.center,
      this.curveRadius,
      this.curveAngle,
      this.fontWeight = FontWeight.normal,
      this.textDecoration = TextDecoration.none,
      this.fontStyle = FontStyle.normal});
}
