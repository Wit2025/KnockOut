import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/TrackingStatus/Widgets/SpinningCirclePainter.dart';

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
