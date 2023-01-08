// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';

class CachedNetworkImageShare extends StatelessWidget {
  final String urlImage;
  final double widthNumber;
  final double heigthNumber;
  final double borderNumber;
  final BoxFit fit;

  // ignore: use_key_in_widget_constructors
  CachedNetworkImageShare(this.urlImage,
      {this.heigthNumber = 200,
      this.widthNumber = 133,
      this.borderNumber = 5,
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderNumber.r),
        child: CachedNetworkImage(
            imageUrl: urlImage,
            imageBuilder: (context, imageProvider) => Container(
                width: widthNumber,
                height: heigthNumber,
                decoration: BoxDecoration(
                    shape: borderNumber == 0
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                    image: DecorationImage(image: imageProvider, fit: fit))),
            placeholder: (context, url) => ClipRRect(
                borderRadius: BorderRadius.circular(borderNumber.r),
                child: SkeletonAnimation(
                    borderRadius: BorderRadius.circular(borderNumber.r),
                    shimmerColor: Colors.grey,
                    child: Container(
                        width: widthNumber.w,
                        height: heigthNumber.h,
                        decoration: BoxDecoration(
                            shape: borderNumber == 0
                                ? BoxShape.circle
                                : BoxShape.rectangle,
                            color: Colors.grey[300])))),
            errorWidget: (context, url, error) => Center(
                child: SizedBox(height: heigthNumber, width: widthNumber))));
  }
}
