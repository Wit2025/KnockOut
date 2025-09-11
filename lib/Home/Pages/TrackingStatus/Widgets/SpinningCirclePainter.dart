import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class SpinningCirclePainter extends CustomPainter {
  final double animationValue;
  final Color mainColor;
  final Color backgroundColor;

  SpinningCirclePainter({
    required this.animationValue,
    required this.mainColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = 2.0 * pi * 0.7;
    final startAngle = animationValue * 2 * pi;

    final gradientPaint = Paint()
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: [
          mainColor.withOpacity(0.3),
          mainColor, // กลาง
          mainColor.withOpacity(0.8),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      gradientPaint,
    );

    // วาดขอบวงกลม
    final borderPaint = Paint()
      ..color = mainColor.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant SpinningCirclePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.mainColor != mainColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
