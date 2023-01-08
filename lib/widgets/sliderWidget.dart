import 'package:editor/utils/app_colors.dart';
import 'package:flutter/material.dart';

sliderWidget(
    double min, double max, int division, double value, Function onPressed) {
  return SliderTheme(
    data: const SliderThemeData(
      valueIndicatorColor: Color(0xffF932B5),
      trackHeight: 2,
    ),
    child: Slider(
      value: value,
      min: min,
      max: max,
      divisions: division,
      activeColor: const Color(0xff71DECA),
      thumbColor: Colors.white,
      label: value.toStringAsFixed(0),
      inactiveColor: kWhiteColor.withOpacity(0.2),
      onChanged: (double newValue) {
        onPressed(newValue);
      },
    ),
  );
}
