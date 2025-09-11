import 'dart:math';

import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/TrackingStatus/Widgets/OuterBubblePainter.dart';
import 'package:knockout/Home/Pages/TrackingStatus/Widgets/WaterProgressPainter.dart';
import 'package:knockout/Home/Pages/TrackingStatus/Widgets/particlesClass.dart';
import 'package:knockout/Widgets/AppColors.dart';

class BubbleProgressCircle extends StatefulWidget {
  final double progress;
  final String remainingTime;

  const BubbleProgressCircle({
    super.key,
    required this.progress,
    required this.remainingTime,
  });

  @override
  State<BubbleProgressCircle> createState() => _BubbleProgressCircleState();
}

class _BubbleProgressCircleState extends State<BubbleProgressCircle>
    with TickerProviderStateMixin {
  late AnimationController _bubbleController;
  late AnimationController _waveController;
  late AnimationController _outerBubbleController;
  late AnimationController _glowController;

  List<Bubble> _bubbles = [];
  List<OuterBubble> _outerBubbles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _outerBubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _generateBubbles();
    _generateOuterBubbles();
  }

  void _generateBubbles() {
    _bubbles.clear();
    for (int i = 0; i < 50; i++) {
      _bubbles.add(
        Bubble(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          radius: _random.nextDouble() * 8 + 3,
          speed: _random.nextDouble() * 0.5 + 0.2,
          opacity: _random.nextDouble() * 0.7 + 0.3,
        ),
      );
    }
  }

  void _generateOuterBubbles() {
    _outerBubbles.clear();
    for (int i = 0; i < 20; i++) {
      _outerBubbles.add(
        OuterBubble(
          angle: _random.nextDouble() * 2 * pi,
          distance: _random.nextDouble() * 60 + 120,
          radius: _random.nextDouble() * 12 + 6,
          speed: _random.nextDouble() * 0.3 + 0.1,
          opacity: _random.nextDouble() * 0.4 + 0.2,
        ),
      );
    }
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _waveController.dispose();
    _outerBubbleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _bubbleController,
        _waveController,
        _outerBubbleController,
        _glowController,
      ]),
      builder: (context, child) {
        return SizedBox(
          width: 280,
          height: 280,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer bubbles effect
              CustomPaint(
                size: const Size(280, 280),
                painter: OuterBubblePainter(
                  bubbles: _outerBubbles,
                  animationValue: _outerBubbleController.value,
                ),
              ),

              // Glow effect
              Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainButton.withOpacity(
                        0.3 + _glowController.value * 0.2,
                      ),
                      blurRadius: 30 + _glowController.value * 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),

              // Main progress circle with wave surface
              Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.mainButton, width: 3),
                ),
                child: ClipOval(
                  child: CustomPaint(
                    size: const Size(240, 240),
                    painter: WaterProgressPainter(
                      progress: widget.progress,
                      waveAnimation: _waveController.value,
                      bubbleAnimation: _bubbleController.value,
                      bubbles: _bubbles,
                    ),
                  ),
                ),
              ),

              // Text content with smooth color transition
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  key: ValueKey(widget.progress > 0.5),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: widget.progress > 0.65
                            ? AppColors.backgroundColor
                            : AppColors.mainButton,
                        shadows: widget.progress > 0.5
                            ? [
                                const Shadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ]
                            : null,
                      ),
                      child: Text('${(widget.progress * 100).round()}%'),
                    ),
                    const SizedBox(height: 8),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: widget.progress > 0.40
                            ? AppColors.backgroundColor
                            : AppColors.mainButton,
                        shadows: widget.progress > 0.5
                            ? [
                                const Shadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                ),
                              ]
                            : null,
                      ),
                      child: Text(widget.remainingTime),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
