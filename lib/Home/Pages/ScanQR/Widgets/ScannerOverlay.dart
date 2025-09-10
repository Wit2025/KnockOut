import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScannerOverlayPainter(),
      child: const Center(
        child: SizedBox(
          width: 250,
          height: 250,
          child: Icon(
            Icons.qr_code_scanner,
            size: 200,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final backgroundPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.textColor.withOpacity(0.5);

    // วาดพื้นหลังทึบรอบๆ
    final path = Path()..addRect(Rect.fromLTRB(0, 0, width, height));

    // ตัดส่วนกลางออก
    final centerRect = Rect.fromCenter(
      center: Offset(width / 2, height / 2),
      width: 250,
      height: 250,
    );
    path.addRect(centerRect);
    path.fillType = PathFillType.evenOdd;

    canvas.drawPath(path, backgroundPaint);

    // วาดมุมของกรอบ
    final cornerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = AppColors.mainButton;

    const cornerLength = 20.0;
    final topLeft = centerRect.topLeft;
    final topRight = centerRect.topRight;
    final bottomLeft = centerRect.bottomLeft;
    final bottomRight = centerRect.bottomRight;

    // มุมบนซ้าย
    canvas.drawLine(
      topLeft,
      Offset(topLeft.dx + cornerLength, topLeft.dy),
      cornerPaint,
    );
    canvas.drawLine(
      topLeft,
      Offset(topLeft.dx, topLeft.dy + cornerLength),
      cornerPaint,
    );

    // มุมบนขวา
    canvas.drawLine(
      topRight,
      Offset(topRight.dx - cornerLength, topRight.dy),
      cornerPaint,
    );
    canvas.drawLine(
      topRight,
      Offset(topRight.dx, topRight.dy + cornerLength),
      cornerPaint,
    );

    // มุมล่างซ้าย
    canvas.drawLine(
      bottomLeft,
      Offset(bottomLeft.dx + cornerLength, bottomLeft.dy),
      cornerPaint,
    );
    canvas.drawLine(
      bottomLeft,
      Offset(bottomLeft.dx, bottomLeft.dy - cornerLength),
      cornerPaint,
    );

    // มุมล่างขวา
    canvas.drawLine(
      bottomRight,
      Offset(bottomRight.dx - cornerLength, bottomRight.dy),
      cornerPaint,
    );
    canvas.drawLine(
      bottomRight,
      Offset(bottomRight.dx, bottomRight.dy - cornerLength),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
