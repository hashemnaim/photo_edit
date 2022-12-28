import 'package:editor/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;

  final Function? onTap;
  final bool? isShowBorder;

  final double? height;
  final double? width;
  final Color color;
  final double fontText;
  final Color? colorText;

  CustomButton(
      {this.text,
      this.onTap,
      this.height = 60,
      this.width = 350,
      this.color = kPrimaryColor,
      this.colorText = Colors.white,
      this.fontText = 16,
      this.isShowBorder});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: SizedBox(
        height: height!,
        width: width!,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                text ?? 'Send',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: fontText,
                      color: colorText,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
