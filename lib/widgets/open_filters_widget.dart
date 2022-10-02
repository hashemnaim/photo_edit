import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

Column openFiltersWidget({Function? onBack,Function? onTap,File? image}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      IconButton(
          onPressed: () => onBack!(),
          icon: Icon(Icons.arrow_back, color: kWhiteColor)),
      Expanded(
        flex: 1,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // _buildFilterThumbnail(presetFiltersList[index], myImage, fileName),
                    ColorFiltered(
                      colorFilter: ColorFilter.matrix(filters[index]),
                      child: Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                            image:
                            DecorationImage(image: FileImage(image!))),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: ()=> onTap!(index),
            );
          },
        )
      ),
    ],
  );
}
