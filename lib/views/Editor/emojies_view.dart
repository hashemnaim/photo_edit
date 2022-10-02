
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/text_model.dart';
import 'image_editor_pro.dart';

// ignore: must_be_immutable
class EmojiView extends StatefulWidget {
   double? left;
   double? top;
   TextModel? mapJson;
   int? index;
   Function(DragUpdateDetails)? onPanUpdate;

   Function? onDelete;

   EmojiView({
    Key? key,
    this.index,
    this.left,
    this.top,
    this.onPanUpdate,
    this.mapJson,
     this.onDelete
  }) : super(key: key);

  @override
  _EmojiViewState createState() => _EmojiViewState();
}

class _EmojiViewState extends State<EmojiView> {
  double finalAngle = 0.0;
  double offsetAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: Transform.rotate(
        angle: finalAngle,
        child: GestureDetector(
          onPanUpdate: widget.onPanUpdate,
          onTap: () {
            for (var element in widgetJson) {
              element.isEdit = false;
            }
            widget.mapJson!.isEdit = true;
            setState(() {});
          },

          child: Stack(
            children: [

              Container(
                margin: const EdgeInsets.all(10),

                child: Container(

                decoration: BoxDecoration(
                  border:  widget.mapJson!.isEdit! ? Border.all(width: 1, color: const Color(0xff1E4355).withOpacity(0.5),) : Border.all(color: Colors.transparent),

                ),

                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.mapJson!.name!,
                    textAlign: widget.mapJson!.align,
                    style: TextStyle(
                      color: widget.mapJson!.color,
                      fontSize: widget.mapJson!.size,
                    ),
                  ),
                ),),),
              widget.mapJson!.isEdit!
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          widget.onDelete!(widget.index);
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: const Color(0xff1E4355).withOpacity(0.5),
                          child: const Icon(Icons.close,size:20),
                        ),
                      ),
                    )
                  : const SizedBox(),

              widget.mapJson!.isEdit!
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      child: GestureDetector(
                        onPanUpdate: (detail) {
                          widgetJson[widget.index!].size =
                              widgetJson[widget.index!].size! + detail.delta.dy;
                          setState(() {});
                        },
                        child: CircleAvatar(
                            radius: 12,
                            backgroundColor: const Color(0xff1E4355).withOpacity(0.5),
                            child: const Icon(Icons.open_in_full,size:20)),
                      ),
                    )
                  : const SizedBox(),

              widget.mapJson!.isEdit!
                  ? Positioned(
                      top: 0,
                      left: 0,
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return GestureDetector(

                            onPanUpdate: (details) {
                              try {
                                Offset centerOfGestureDetector = Offset(
                                    constraints.maxWidth / 2,
                                    constraints.maxHeight / 2);
                                final touchPositionFromCenter =
                                    details.localPosition -
                                        centerOfGestureDetector;

                                setState(
                                  () {
                                    finalAngle =
                                        touchPositionFromCenter.direction -
                                            offsetAngle;
                                  },
                                );
                              } catch (e) {
                                if (kDebugMode) {
                                  print("\n\n\nError ha yar $e \n\n\n");
                                }
                              }
                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: const Color(0xff1E4355).withOpacity(0.5),
                              child: const Icon(Icons.rotate_right,size:20),
                            ),
                          );
                        }),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),

          //  Text(
          //   widget.mapJson['name'],
          //   textAlign: widget.mapJson['align'],
          //   style: TextStyle(
          //     color: widget.mapJson['color'],
          //     fontSize: widget.mapJson['size'],
          //   ),
          // ),
        ),
      ),
    );
  }
}
