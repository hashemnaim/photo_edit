import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editor/models/sticker_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../views/subStickers.dart';
import '../cash_network_image.dart';
import '../textStyle.dart';

class StickerListWidget extends StatelessWidget {
  const StickerListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Stickers').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
                height: Get.height * 0.2,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }

          final data = snapshot.data!.docs;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, right: 0),
                child: Text(
                  'New Sticker in TextOnPhoto'.tr,
                  style: myTextStyle(17, FontWeight.w400, kWhiteColor),
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                itemBuilder: (ctx, i) {
                  MySticker sticker = MySticker.fromJson(data[i].data());

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SubStickers(
                                  title: sticker.title!,
                                ));
                          },
                          child: Container(
                              margin:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              height: Get.height * 0.18,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: CachedNetworkImageShare(
                                  sticker.imageUrl!,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sticker.title!.tr,
                              style:
                                  myTextStyle(16, FontWeight.w400, kWhiteColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          );
        });
  }
}
