import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../models/font_model.dart';
import '../models/text_model.dart';
import '../utils/app_colors.dart';
import '../views/Editor/image_editor_pro.dart';

SingleChildScrollView openStickersWidget({Function? onBack,Widget? title,ScrollController? scrollControllerForYou,Function? onSelected}) {



  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
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
              )
            ],
          ),
        ),
        Container(
            padding:const EdgeInsets.symmetric(horizontal: 10),
            child:StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('stickerIcons').snapshots(),
              builder: (ctx,snapshot){
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator());
                }

                final data = snapshot.data!.docs;
                return  GridView.builder(

                  itemCount: data.length,
                  gridDelegate:
                 const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 9,
                  ),
                  itemBuilder: (ctx, i) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              color:
                            const  Color(0xff076994).withOpacity(0.5))),
                      child: InkWell(
                        onTap: () {

                          var value = TextModel(
                            name: data[i].get('imageUrl'),
                            isEdit: true,
                            align: TextAlign.center,
                            color: kBlackColor,
                            size: 100.0,
                            type: 3,
                            myFontModel: FontModel(Colors.transparent,
                                isUseCurved: false,
                                isBackgroundContained: false,
                                textStyle:const TextStyle(),
                                textFontSize: 100.0,
                                textFontWidth: 30.0,
                                textFontHeight: 20.0,
                                textColor: kBlackColor,
                                textShadow:const Shadow(),
                                textBackgroundBorderSize: 1.0,
                                textBackgroundColor: kWhiteColor,
                                textBackgroundOpacity: 1.0,
                                textBorderOpacity: 1.0,
                                textBorderRadius: 0.0,
                                textOpacity: 1.0,
                                curveAngle: 0.0),
                          );
                          for (var element in widgetJson) {
                            element.isEdit = false;
                          }

                          widgetJson.add(value);

                          onSelected!();},
                        child: Container(
                          // width: 70,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(data[i].get('imageUrl')),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                );
              },
            )),
      ],
    ),
  );
}
