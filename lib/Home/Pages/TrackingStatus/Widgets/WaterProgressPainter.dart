import 'dart:math';

import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/TrackingStatus/Widgets/particlesClass.dart';
import 'package:knockout/Widgets/AppColors.dart';

class WaterProgressPainter extends CustomPainter {
  final double progress;
  final double waveAnimation;
  final double bubbleAnimation;
  final List<Bubble> bubbles;

  WaterProgressPainter({
    required this.progress,
    required this.waveAnimation,
    required this.bubbleAnimation,
    required this.bubbles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // Create water level path with wave surface
    final waterPath = Path();
    final waterHeight = height * progress;
    final waveHeight = 10.0; // Height of the waves
    final waveFrequency = 1.0; // Number of waves across the width

    // Start from bottom left
    waterPath.moveTo(0, height);
    waterPath.lineTo(0, height - waterHeight + waveHeight);

    // Create wave surface with seamless looping
    final waveOffset = waveAnimation * width * 2; // Offset for smooth movement

    for (double x = 0; x <= width; x += 2) {
      // Calculate wave Y position with smooth continuous movement
      final normalizedX = (x + waveOffset) % (width * 2);
      final waveY =
          height -
          waterHeight +
          sin((normalizedX / width * waveFrequency * 2 * pi)) * waveHeight +
          cos((normalizedX / width * waveFrequency * 3 * pi)) *
              waveHeight *
              0.6 +
          sin((normalizedX / width * waveFrequency * 5 * pi)) *
              waveHeight *
              0.3;

      waterPath.lineTo(x, waveY);
    }

    // Complete the path
    waterPath.lineTo(width, height);
    waterPath.close();

    // Create water gradient
    final waterGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.mainButton.withOpacity(0.5), // Lighter blue at top
        AppColors.mainButton, // Medium blue
        AppColors.iconSelect, // Darker blue at bottom
      ],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(Rect.fromLTWH(0, 0, width, height));

    final waterPaint = Paint()
      ..shader = waterGradient
      ..style = PaintingStyle.fill;

    canvas.drawPath(waterPath, waterPaint);

    // Draw bubbles inside the water
    for (final bubble in bubbles) {
      final bubbleY = bubble.y + (bubbleAnimation * bubble.speed * 2) % 1;
      final bubbleX = bubble.x + sin(bubbleAnimation * bubble.speed * 4) * 0.05;

      // Check if bubble is inside water area
      final bubblePixelY = bubbleY * height;
      final bubblePixelX = bubbleX * width;

      // Calculate wave height at bubble position for more accurate collision
      final normalizedX = (bubblePixelX + waveOffset) % (width * 2);
      final waveAtBubble =
          height -
          waterHeight +
          sin((normalizedX / width * waveFrequency * 2 * pi)) * waveHeight +
          cos((normalizedX / width * waveFrequency * 3 * pi)) *
              waveHeight *
              0.6;

      if (bubblePixelY < waveAtBubble) {
        final bubblePaint = Paint()
          ..color = AppColors.mainButton.withOpacity(bubble.opacity * 0.7)
          ..style = PaintingStyle.fill;

        final bubbleCenter = Offset(bubblePixelX, bubblePixelY);

        // Main bubble
        canvas.drawCircle(bubbleCenter, bubble.radius, bubblePaint);

        // Bubble highlight
        final highlightPaint = Paint()
          ..color = AppColors.backgroundColor.withOpacity(bubble.opacity)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(
          bubbleCenter - Offset(bubble.radius * 0.3, bubble.radius * 0.3),
          bubble.radius * 0.3,
          highlightPaint,
        );
      }
    }

    // Add wave surface highlight effect
    final waveHighlightPath = Path();
    for (double x = 0; x <= width; x += 2) {
      final normalizedX = (x + waveOffset) % (width * 2);
      final waveY =
          height -
          waterHeight +
          sin((normalizedX / width * waveFrequency * 2 * pi)) * waveHeight +
          cos((normalizedX / width * waveFrequency * 3 * pi)) *
              waveHeight *
              0.6 +
          sin((normalizedX / width * waveFrequency * 5 * pi)) *
              waveHeight *
              0.3;

      if (x == 0) {
        waveHighlightPath.moveTo(x, waveY);
      } else {
        waveHighlightPath.lineTo(x, waveY);
      }
    }

    // Draw wave highlight line
    final waveHighlightPaint = Paint()
      ..color = AppColors.backgroundColor.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

    canvas.drawPath(waveHighlightPath, waveHighlightPaint);

    // Add subtle shimmer effect
    final shimmerPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.backgroundColor.withOpacity(0.1),
          AppColors.backgroundColor.withOpacity(0.1),
          AppColors.backgroundColor.withOpacity(0.1),
        ],
        stops: [
          (waveAnimation - 0.3).clamp(0.0, 1.0),
          waveAnimation,
          (waveAnimation + 0.3).clamp(0.0, 1.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, width, height));

    canvas.drawPath(waterPath, shimmerPaint);
  }

  @override
  bool shouldRepaint(covariant WaterProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.waveAnimation != waveAnimation ||
        oldDelegate.bubbleAnimation != bubbleAnimation;
  }
}
