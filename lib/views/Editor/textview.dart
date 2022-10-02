import 'dart:math';

import 'package:editor/views/curveText.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/text_model.dart';
import 'image_editor_pro.dart';

// ignore: must_be_immutable
class TextView extends StatefulWidget {
   double? left;
   double? top;
   Function? onTap;
   Function(DragUpdateDetails)? onPanUpdate;
   Function? onEdit;

   TextModel? mapJson;
   TextStyle? textStyle;
   Shadow? myShadow;
   double? fontSize;
   Color? currentColor;
   double? borderRadius;
   Color? backgroundColor;
   double? paddingWidth;
   double? paddingHeight;
   TextAlign? myAlignment;
   double? textOpacity;
   double? backgroundOpacity;
   double? borderOpacity;
   Color? backgroundBorderColor;
   double? backgroundBorderSize;
   double? curveRadius;
   double? curveAngle;
   FontWeight? fontWeight;
   TextDecoration? textDecoration;
   FontStyle? fontStyle;
   double? width;
  bool? isUseCurveText = false;
  TextView(this.width, this.isUseCurveText,
      {Key? key,
      this.onEdit,
      this.left,
      this.top,
      this.onTap,
      this.onPanUpdate,
      this.mapJson,
      this.textStyle,
      this.myShadow,
      this.fontSize,
      this.currentColor = Colors.black,
      this.borderRadius,
      this.backgroundColor,
      this.paddingWidth = 0,
      this.paddingHeight = 0,
      this.myAlignment,
      this.textOpacity,
      this.backgroundOpacity,
      this.borderOpacity,
      this.backgroundBorderColor,
      this.backgroundBorderSize,
      this.curveRadius,
      this.curveAngle,
      this.fontWeight,
      this.textDecoration,
      this.fontStyle})
      : super(key: key);

  @override
  _TextViewState createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  bool isContainerExist = true;
  double finalAngle = 0.0;
  double offsetAngle = 0.0;

  @override
  void initState() {
    // isEdit = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('value of bool is : ${isEdit}');

    return Positioned(
      left: widget.left,
      top: widget.top,
      child: GestureDetector(
        onTap: ()=> widget.onTap!(),
        onPanUpdate: widget.onPanUpdate,
        child: isContainerExist
            ? Transform.rotate(
                angle: finalAngle,
                child: InkWell(
                  onTap: () {
                    for (var e in widgetJson) {
                      e.isEdit = false;
                    }

                    int indexOfCurrentWidget =
                        widgetJson.indexOf(widget.mapJson!);
                    widgetJson[indexOfCurrentWidget].isEdit = true;
                    setState(() {
                      widget.mapJson!.isEdit = true;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: widget.backgroundBorderSize == 0 &&
                              widget.mapJson!.isEdit!
                              ? Border.all(color: const Color(0xff49ADF3))
                              : Border.all(
                              color: widget.backgroundBorderSize == 0
                                  ? Colors.transparent
                                  : widget.backgroundBorderColor
                              !.withOpacity(widget.borderOpacity!),
                              width: widget.backgroundBorderSize!),
                          borderRadius:
                          BorderRadius.circular(widget.borderRadius!),
                          color: (!widget.mapJson!.myFontModel!
                              .isBackgroundContained! &&
                              !widget.mapJson!.isEdit!)
                              ? Colors.transparent
                              : widget.backgroundColor
                          !.withOpacity(widget.backgroundOpacity!),
                        ),
                        width: widget.width,
                        margin: const EdgeInsets.all(20),
                        padding: EdgeInsets.symmetric(
                            horizontal: widget.paddingWidth!,
                            vertical: widget.paddingHeight!),
                        child: !widget.isUseCurveText!
                            ? Text(
                          widget.mapJson!.name!,
                          textAlign: widget.myAlignment,
                          style: widget.textStyle!.copyWith(
                            fontStyle: widget.fontStyle,
                            decoration: widget.textDecoration,
                            fontWeight: widget.fontWeight,
                            fontSize: widget.fontSize,
                            shadows: [widget.myShadow!],
                            color: widget.currentColor
                            !.withOpacity(widget.textOpacity!),
                          ),
                        )
                            : ArcText(
                          stretchAngle: 300,
                          radius: widget.curveRadius,
                          text: widget.mapJson!.name!,
                          startAngle: widget.curveAngle! * pi / 180,
                          textStyle: widget.textStyle!.copyWith(
                            decoration: widget.textDecoration,
                            fontWeight: widget.fontWeight,
                            fontStyle: widget.fontStyle,
                            fontSize: widget.fontSize,
                            shadows: [widget.myShadow!],
                            color: widget.currentColor
                            !.withOpacity(widget.textOpacity!),
                          ),
                        ),
                      ),
                      //remove
                      widget.mapJson!.isEdit!
                          ? Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            isContainerExist = false;
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                            const Color(0xff1E4355).withOpacity(0.5),
                            child: const Icon(
                              Icons.close,
                              size: 18,
                            ),
                          ),
                        ),
                      )
                          :const  SizedBox(),
                      //edit
                      widget.mapJson!.isEdit!
                          ? Positioned(
                        top: 0,
                        left: 0,
                        child: InkWell(
                          onTap: () {
                            widget.onEdit!();
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                            const Color(0xff1E4355).withOpacity(0.5),
                            child: const Icon(
                              Icons.edit,
                              size: 18,
                            ),
                          ),
                        ),
                      )
                          : const SizedBox(),
                      // rotation
                      widget.mapJson!.isEdit!
                          ? Positioned(
                        bottom: 0,
                        right: 0,
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: LayoutBuilder(
                              builder: (context, constraints) {
                                return GestureDetector(
                                  onPanUpdate: (details) {
                                    try {
                                      Offset centerOfGestureDetector =
                                      Offset(constraints.maxWidth / 2,
                                          constraints.maxHeight / 2);
                                      final touchPositionFromCenter =
                                          details.localPosition -
                                              centerOfGestureDetector;

                                      setState(
                                            () {
                                          finalAngle =
                                              touchPositionFromCenter
                                                  .direction -
                                                  offsetAngle;
                                        },
                                      );
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print("\n\n\n Error ha yar  \n\n\n");
                                      }
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                    const Color(0xff1E4355).withOpacity(0.5),
                                    child:
                                    const Icon(Icons.rotate_right, size: 20),
                                  ),
                                );
                              }),
                        ),
                      )
                          : const SizedBox(),
                    ],
                  )
                ),
              )
            : Container(),
      ),
    );
  }
}
