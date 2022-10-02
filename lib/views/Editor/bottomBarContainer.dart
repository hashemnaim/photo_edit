import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

// ignore: must_be_immutable
class BottomBarContainer extends StatelessWidget {
   Color? colors;
   Function? onTap;
   String? title;
   IconData? icons;
   String? imageIcon;

   BottomBarContainer(
      {Key? key,
      this.onTap,
      this.title,
      this.icons,
      this.colors,
      this.imageIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
       width: MediaQuery.of(context).size.width / 4,
      child: InkWell(
        onTap: ()=> onTap!(),
        child: Column(
          children: [
            //
            imageIcon == null
                ? Icon(icons, color: kWhiteColor)
                : SizedBox(
                    height: 22,
                    width: 22,
                    child: Image.asset(
                      imageIcon!,
                      color: kWhiteColor,
                    )),
            const SizedBox(height: 6),
            Text(
              title!,
              style: TextStyle(color: kWhiteColor, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
