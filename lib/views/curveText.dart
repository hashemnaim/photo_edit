import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ArcText extends StatelessWidget {
  ArcText({
    Key? key,
    this.radius,
    this.text,
    this.textStyle,
    this.startAngle = 0,
    this.stretchAngle,
  }) : super(key: key);

  double? radius;
  String? text;
  double? startAngle;
  TextStyle? textStyle;
  double? stretchAngle;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _Painter(
          radius,
          text,
          textStyle,
          initialAngle: startAngle,
        ),
      );
}

class _Painter extends CustomPainter {
  _Painter(this.radius, this.text, this.textStyle, {this.initialAngle = -20});

  double? radius;
  String? text;
  double? initialAngle;
  TextStyle? textStyle;
  double? stretchAngle;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2 - radius!, size.height / 2 - radius!);

    if (initialAngle != 0) {
      final d = 2 * radius! * math.sin(initialAngle! / 2);
      final rotationAngle = _calculateRotationAngle(0, initialAngle!);
      canvas.rotate(rotationAngle);
      canvas.translate(d, 0);
    }

    double angle = initialAngle!;
    for (int i = 0; i < text!.length; i++) {
      angle = _drawLetter(canvas, text![i], angle);
    }
  }

  double _drawLetter(Canvas canvas, String letter, double prevAngle) {
    _textPainter.text = TextSpan(text: letter, style: textStyle);
    _textPainter.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );

    final double d = _textPainter.width;
    final double alpha = 2 * math.asin(d / (2 * radius!));

    final newAngle = _calculateRotationAngle(prevAngle, alpha);
    canvas.rotate(newAngle);

    _textPainter.paint(canvas, Offset(0, -_textPainter.height));
    canvas.translate(d, 0);

    return alpha;
  }

  double _calculateRotationAngle(double prevAngle, double alpha) =>
      (alpha + prevAngle) / 2;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
