import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../utils/app_colors.dart';

SingleChildScrollView openFramesWidget(
    {Function? onTap,
    Widget? title,

    Function? framesOnTap}) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => onTap!(),
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
        const SizedBox(
          height: 8,
        ),
        Container(
          padding:const EdgeInsets.symmetric(horizontal: 10),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('frames')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final data = snapshot.data!.docs;

                  return  GridView.builder(
                    itemCount: data.length + 1,
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 9,
                    ),
                    itemBuilder: (ctx, i) {
                      return InkWell(
                        ///todo: this need to be done
                        onTap: () => framesOnTap!(
                            i, i == 0 ? '' : data[i - 1].get('imageUrl')),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color:const Color(0xff076994)
                                        .withOpacity(0.5))),
                            child: i - 1 == -1
                                ?  Center(
                              child: Text(
                                "None",
                                style: TextStyle(color: kWhiteColor),
                              ),
                            )
                                : Container(
                              width: 70,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      data[i - 1].get('imageUrl')),
                                ),
                              ),
                            )),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  );
                })
          ]),
        )
      ],
    )
  );
}
