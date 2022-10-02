import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'dart:math' as math;

openTextColorWidget(context,
    {Function? onBack,
    Widget? title,
    Color? pickerColor,
    Function? changeColor,
    Function? gotIt,
    Widget? colorPicker}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: SingleChildScrollView(
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
                              onColorChanged: (c) => changeColor!(c),
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Got it'),
                              onPressed: () => gotIt!(),
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  width: 28,
                  height: 28,
                  padding: const EdgeInsets.all(4),
                  child: Image.asset('images/newIcons/color-picker (1) 1.png'),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xff71DECAC9), width: 2),
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          colorPicker!,
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
}
