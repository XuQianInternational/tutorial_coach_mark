import 'dart:math';

import 'package:flutter/material.dart';

class LightPaint extends CustomPainter {
  final double progress;
  final Offset positioned;
  final Offset? tappablePositioned;
  final double sizeCircle;
  final double? tappableSizeCircle;
  final Color colorShadow;
  final double opacityShadow;
  final BorderSide? borderSide;
  final BorderSide? tappableBorderSide;
  final double staticProgress;

  LightPaint({
    required this.progress,
    required this.staticProgress,
    required this.positioned,
    required this.tappablePositioned,
    required this.sizeCircle,
    required this.tappableSizeCircle,
    this.colorShadow = Colors.black,
    this.opacityShadow = 0.8,
    this.borderSide,
    this.tappableBorderSide,
  }) : assert(opacityShadow >= 0 && opacityShadow <= 1);

  @override
  void paint(Canvas canvas, Size size) {
    if (positioned == Offset.zero) return;
    var maxSize = max(size.width, size.height);
    // print('progress = $progress');

    final haveTappable = tappableSizeCircle != null &&
        tappablePositioned != null &&
        tappableBorderSide != null &&
        tappableBorderSide?.style != BorderStyle.none;
    double radius;
    if (haveTappable) {
      radius = maxSize * (1 - staticProgress) + sizeCircle;
    } else {
      radius = maxSize * (1 - progress) + sizeCircle;
    }

    // There is some weirdness here.  On mobile, using arcTo with `sweepAngle: 2 * pi`
    // gives the equivalent of `sweepAngle: 0`.  I couldn't find any documentation
    // of the expected behavior here, so instead I just call arcTo twice (two
    // semi-circles) to outline the full hole.
    final circleHole = Path()
      ..moveTo(0, 0)
      ..lineTo(0, positioned.dy)
      ..arcTo(
        Rect.fromCircle(center: positioned, radius: radius),
        pi,
        pi,
        false,
      )
      ..arcTo(
        Rect.fromCircle(center: positioned, radius: radius),
        0,
        pi,
        false,
      )
      ..lineTo(0, positioned.dy)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    final justCircleHole = Path()
      ..moveTo(positioned.dx - radius, positioned.dy)
      ..arcTo(
        Rect.fromCircle(center: positioned, radius: radius),
        pi,
        pi,
        false,
      )
      ..arcTo(
        Rect.fromCircle(center: positioned, radius: radius),
        0,
        pi,
        false,
      )
      ..close();

    canvas.drawPath(
      circleHole,
      Paint()
        ..style = PaintingStyle.fill
        ..color = colorShadow.withOpacity(opacityShadow),
    );
    if (borderSide != null && borderSide?.style != BorderStyle.none) {
      canvas.drawPath(
          justCircleHole,
          Paint()
            ..style = PaintingStyle.stroke
            ..color = borderSide!.color
            ..strokeWidth = borderSide!.width);
    }
  }

  @override
  bool shouldRepaint(LightPaint oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
