import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';
import 'dart:async';

class RealtimeTrackingPage extends StatefulWidget {
  final int? processTime;

  const RealtimeTrackingPage({super.key, this.processTime});

  @override
  _RealtimeTrackingPageState createState() => _RealtimeTrackingPageState();
}

class _RealtimeTrackingPageState extends State<RealtimeTrackingPage> {
  double progress = 0.0;
  int remainingTime = 0;
  Timer? _timer;
  bool isProcessing = false;
  int totalTime = 0;
  int elapsedTime = 0;

  @override
  void initState() {
    super.initState();

    // ถ้ามีการส่งเวลามา ให้เริ่มนับเวลา
    if (widget.processTime != null && widget.processTime! > 0) {
      totalTime = widget.processTime! * 60;
      remainingTime = totalTime;
      isProcessing = true;
      _startProgress();
    }
  }

  void _startProgress() {
    if (!isProcessing || totalTime <= 0) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        elapsedTime++;
        remainingTime = totalTime - elapsedTime;
        progress = elapsedTime / totalTime;
      });

      // ถ้าเสร็จแล้ว
      if (elapsedTime >= totalTime) {
        timer.cancel();
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 80,
                    color: AppColors.mainButton,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'ສຳເລັດສົມບູນແລ້ວ!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'ທ່ານສາມາດເອົາໝວກຂອງທ່ານອອກໄດ້ແລ້ວ',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainButton,
                      foregroundColor: AppColors.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text("ຕົກລົງ"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar:
          isProcessing // แสดง AppBar เฉพาะเมื่อกำลังซักผ้า
          ? AppBar(
              title: const Text(
                'ສະຖານະການເຮັດວຽກ',
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.backgroundColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              elevation: 0,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.iconSelect, AppColors.mainButton],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isProcessing ? 'ກຳລັງລ້າງ...' : 'ບໍ່ມີວຽກທີ່ກຳລັງດຳເນີນການ',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                if (isProcessing) ...[
                  const SizedBox(height: 30),

                  // Enhanced Blue Bubble Progress Circle
                  BubbleProgressCircle(
                    progress: progress,
                    remainingTime: _formatTime(remainingTime),
                  ),

                  const SizedBox(height: 80),

                  // แสดงขั้นตอนการทำงาน
                  _buildProcessSteps(),
                ] else ...[
                  const SizedBox(height: 30),
                  const Text(
                    'ບໍ່ມີວຽກທີ່ກຳລັງດຳເນີນການ',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.borderColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProcessSteps() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainButton.withOpacity(0.7),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.backgroundColor, AppColors.backgroundColor],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              const Text(
                'ຂັ້ນຕອນການເຮັດວຽກ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAnimatedStepIndicator('ຕື່ມນ້ຳ', progress > 0.1, 0),
          _buildAnimatedStepIndicator('ລ້າງໝວກ', progress > 0.3, 1),
          _buildAnimatedStepIndicator('ລ້າງນ້ຳ', progress > 0.7, 2),
          _buildAnimatedStepIndicator('ປັ້ນແຫ້ງ', progress > 0.9, 3),
        ],
      ),
    );
  }

  Widget _buildAnimatedStepIndicator(String step, bool isCompleted, int index) {
    // คำนวณว่า step นี้กำลังทำงานอยู่หรือไม่
    bool isActive = false;

    if (index == 0) {
      isActive = progress > 0 && progress <= 0.1;
    } else if (index == 1) {
      isActive = progress > 0.1 && progress <= 0.3;
    } else if (index == 2) {
      isActive = progress > 0.3 && progress <= 0.7;
    } else if (index == 3) {
      isActive = progress > 0.7 && progress <= 0.9;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 500 + (index * 200)),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppColors.success.withOpacity(0.1)
            : AppColors.borderColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted
              ? AppColors.success.withOpacity(0.3)
              : AppColors.borderColor.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: isCompleted
            ? [
                BoxShadow(
                  color: AppColors.success.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // แสดงการหมุนเฉพาะเมื่อกำลังทำงาน (isActive) และยังไม่เสร็จ
          isCompleted
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutBack,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.backgroundColor,
                    size: 16,
                  ),
                )
              : isActive
              ? SpinningCircleWidget(
                  mainColor: AppColors.mainButton,
                  backgroundColor: AppColors.backgroundColor,
                )
              : Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.circle,
                    color: AppColors.backgroundColor,
                    size: 16,
                  ),
                ),
          const SizedBox(width: 16),
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 16,
                fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
                color: isCompleted ? AppColors.success : AppColors.textColor,
                decoration: isCompleted
                    ? TextDecoration.none
                    : TextDecoration.none,
              ),
              child: Text(step),
            ),
          ),
          if (isCompleted)
            Icon(Icons.verified_rounded, color: AppColors.success, size: 20),
        ],
      ),
    );
  }
}

// Enhanced Blue Bubble Progress Circle
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

class SpinningCircleWidget extends StatefulWidget {
  final Color mainColor;
  final Color backgroundColor;

  const SpinningCircleWidget({
    super.key,
    required this.mainColor,
    required this.backgroundColor,
  });

  @override
  State<SpinningCircleWidget> createState() => _SpinningCircleWidgetState();
}

class _SpinningCircleWidgetState extends State<SpinningCircleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(24, 24),
          painter: SpinningCirclePainter(
            animationValue: _controller.value,
            mainColor: widget.mainColor,
            backgroundColor: widget.backgroundColor,
          ),
        );
      },
    );
  }
}

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

    // วาดพื้นหลังวงกลม
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, backgroundPaint);

    // วาดวงกลมหมุนแบบไล่สี (Arc)
    final sweepAngle = 2.0 * pi * 0.7; // 70% ของวงกลม
    final startAngle = animationValue * 2 * pi;

    final gradientPaint = Paint()
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: [
          mainColor.withOpacity(0.3), // หางจาง
          mainColor, // กลาง
          mainColor.withOpacity(0.8), // หัวเข้ม
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
    for (int i = 0; i < 15; i++) {
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
    for (int i = 0; i < 8; i++) {
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

// Data classes for particles
class Bubble {
  double x;
  double y;
  double radius;
  double speed;
  double opacity;

  Bubble({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.opacity,
  });
}

class OuterBubble {
  double angle;
  double distance;
  double radius;
  double speed;
  double opacity;

  OuterBubble({
    required this.angle,
    required this.distance,
    required this.radius,
    required this.speed,
    required this.opacity,
  });
}

// Water Progress Painter with Wave Surface
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

      if (bubblePixelY > waveAtBubble) {
        final bubblePaint = Paint()
          ..color = AppColors.backgroundColor.withOpacity(bubble.opacity * 0.8)
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
          AppColors.backgroundColor.withOpacity(0.0),
          AppColors.backgroundColor.withOpacity(0.1),
          AppColors.backgroundColor.withOpacity(0.0),
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

class OuterBubblePainter extends CustomPainter {
  final List<OuterBubble> bubbles;
  final double animationValue;

  OuterBubblePainter({required this.bubbles, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (final bubble in bubbles) {
      final currentAngle =
          bubble.angle + (animationValue * bubble.speed * 2 * pi);
      final currentDistance =
          bubble.distance + sin(animationValue * bubble.speed * 4) * 20;

      final bubblePosition = Offset(
        center.dx + cos(currentAngle) * currentDistance,
        center.dy + sin(currentAngle) * currentDistance,
      );

      final bubblePaint = Paint()
        ..color = AppColors.mainButton.withOpacity(bubble.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(bubblePosition, bubble.radius, bubblePaint);

      // Bubble highlight
      final highlightPaint = Paint()
        ..color = AppColors.backgroundColor.withOpacity(bubble.opacity * 0.7)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        bubblePosition - Offset(bubble.radius * 0.3, bubble.radius * 0.3),
        bubble.radius * 0.3,
        highlightPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant OuterBubblePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
