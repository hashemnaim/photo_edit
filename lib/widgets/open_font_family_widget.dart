import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../models/text_model.dart';
import '../utils/constants.dart';
import '../views/Editor/image_editor_pro.dart';

SingleChildScrollView openFontFamilyWidget({Function? onBack,Widget? title,Function? onPress}) {



  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            Container(
              width: 30,
            ),
          ],
        ),
       const SizedBox(
          height: 8,
        ),
        Container(
          padding:const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
              itemCount: myFontFamilyList.length,
              shrinkWrap: true,
              physics:const NeverScrollableScrollPhysics(),
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 4.0,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (ctx, i) {
                return InkWell(
                  onTap: () {
                    TextModel currentText = widgetJson
                        .firstWhere((element) => element.isEdit == true);

                    int currentIndex = widgetJson.indexOf(currentText);

                    widgetJson[currentIndex].myFontModel!.textStyle =
                        widgetJson[currentIndex]
                            .myFontModel!
                            .textStyle!
                            .copyWith(
                            fontFamily: myFontFamilyList[i].fontName);

                    onPress!();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:const Color(0xff49ADF3).withOpacity(0.6)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // width: 70,
                    child: Text(myFontFamilyList[i].fontName!.split(' ')[0],
                        style: TextStyle(
                            fontFamily: myFontFamilyList[i].fontName,
                            color: Colors.white,
                            fontSize: 16)),
                  ),
                );
              }),
        ),
      ],
    ),
  );
}
