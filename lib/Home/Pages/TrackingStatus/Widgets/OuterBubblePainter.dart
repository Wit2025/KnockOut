import 'dart:math';

import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/TrackingStatus/Widgets/particlesClass.dart';
import 'package:knockout/Widgets/AppColors.dart';

class OuterBubblePainter extends CustomPainter {
  final List<OuterBubble> bubbles;
  final double animationValue;

  OuterBubblePainter({required this.bubbles, required this.animationValue});

  final List<Color> _bubbleColors = [
    AppColors.mainButton,
    AppColors.iconSelect,
    AppColors.darkButton,
    AppColors.error,
    AppColors.warning,
    AppColors.borderColor,
    AppColors.iconUnselect,
    AppColors.backgroundColor,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < bubbles.length; i++) {
      final bubble = bubbles[i];
      final currentAngle =
          bubble.angle + (animationValue * bubble.speed * 2 * pi);
      final currentDistance =
          bubble.distance + sin(animationValue * bubble.speed * 4) * 20;

      final bubblePosition = Offset(
        center.dx + cos(currentAngle) * currentDistance,
        center.dy + sin(currentAngle) * currentDistance,
      );

      // เลือกสีจากลิสต์โดยใช้ index ของฟอง mod ด้วยจำนวนสี
      final bubbleColor = _bubbleColors[i % _bubbleColors.length];

      // เพิ่มเงาให้ฟองสบู่
      final shadowPaint = Paint()
        ..color = Colors.black.withOpacity(bubble.opacity * 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      canvas.drawCircle(
        bubblePosition + const Offset(2, 2),
        bubble.radius,
        shadowPaint,
      );

      final bubblePaint = Paint()
        ..color = bubbleColor.withOpacity(bubble.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(bubblePosition, bubble.radius, bubblePaint);

      // Bubble highlight - ทำให้เห็นชัดขึ้นบนพื้นหลังสีขาว
      final highlightPaint = Paint()
        ..color = Colors.white
            .withOpacity(bubble.opacity * 0.8) // เปลี่ยนเป็นสีขาว
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        bubblePosition - Offset(bubble.radius * 0.3, bubble.radius * 0.3),
        bubble.radius * 0.4, // ขนาดใหญ่ขึ้นเล็กน้อย
        highlightPaint,
      );

      // เพิ่มขอบให้ฟองสบู่เพื่อให้เห็นชัดเจนขึ้น
      final borderPaint = Paint()
        ..color = Colors.black.withOpacity(bubble.opacity * 0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      canvas.drawCircle(bubblePosition, bubble.radius, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant OuterBubblePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
