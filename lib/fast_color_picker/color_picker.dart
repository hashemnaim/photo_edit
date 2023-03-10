import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spring_button/spring_button.dart';
import 'constants.dart';

final Map<int, double> _correctSizes = {};
final PageController pageController = PageController(keepPage: true);

// ignore: must_be_immutable
class FastColorPickers extends StatelessWidget {
  Color? selectedColor;
  IconData? icon;
  Function(Color)? onColorSelected;
  double? width = Get.width;

  FastColorPickers(
      {Key? key,
      this.icon,
      this.selectedColor = Colors.white,
      this.onColorSelected,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: SelectedColor(
                  icon: icon,
                  selectedColor: selectedColor,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: PageView(
                    controller: pageController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Row(
                        children: createColors(context, Constants.colors1),
                      ),
                      Row(
                        children: createColors(context, Constants.colors2),
                      ),
                      Row(
                        children: createColors(context, Constants.colors3),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SmoothPageIndicator(
            controller: pageController, // PageController
            count: 3,
            effect: const ScrollingDotsEffect(
              spacing: 8,
              activeDotColor: Colors.white,
              dotColor: Colors.white24,
              dotHeight: 5,
              dotWidth: 5,
              activeDotScale: 1,
            ),
          ),
          const SizedBox(height: 6)
        ],
      ),
    );
  }

  List<Widget> createColors(BuildContext context, List<Color> colors) {
    double size = _correctSizes[colors.length] ??
        correctButtonSize(
          colors.length,
          MediaQuery.of(context).size.width,
        );
    return [
      for (var c in colors)
        SpringButton(
          SpringButtonType.OnlyScale,
          Padding(
            padding: EdgeInsets.all(size * 0.1),
            child: AnimatedContainer(
              width: size,
              height: size,
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
                border: Border.all(
                  width: c == selectedColor ? 4 : 2,
                  color: Colors.white,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: size * 0.1,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            onColorSelected!.call(c);
          },
          useCache: false,
          scaleCoefficient: 0.9,
          duration: 1000,
        ),
    ];
  }

  double correctButtonSize(int itemSize, double screenWidth) {
    double firstSize = 52;
    double maxWidth = screenWidth - firstSize;
    bool isSizeOkay = false;
    double finalSize = 48;
    do {
      finalSize -= 2;
      double eachSize = finalSize * 1.2;
      double buttonsArea = itemSize * eachSize;
      isSizeOkay = maxWidth > buttonsArea;
    } while (!isSizeOkay);
    _correctSizes[itemSize] = finalSize;
    return finalSize;
  }
}

// ignore: must_be_immutable
class SelectedColor extends StatelessWidget {
  Color? selectedColor;
  IconData? icon;

  SelectedColor({Key? key, this.selectedColor, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      child: icon != null
          ? Icon(
              icon,
              color: selectedColor!.computeLuminance() > 0.5
                  ? Colors.black
                  : Colors.white,
              size: 22,
            )
          : Container(),
      decoration: BoxDecoration(
        color: selectedColor,
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black38,
          ),
        ],
      ),
    );
  }
}
