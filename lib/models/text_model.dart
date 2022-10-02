import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'font_model.dart';

class TextModel {
  String? name;
  Color? color;
  double? size;
  double? width = Get.width - 60;

  TextAlign? align;
  bool? isEdit;
  int? type;
  FontModel? myFontModel;

  TextModel({
    this.name,
    this.color,
    this.size,
    this.align,
    this.isEdit,
    this.type,
    this.myFontModel,
  });
}
