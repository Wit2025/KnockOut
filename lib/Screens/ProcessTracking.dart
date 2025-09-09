import 'package:flutter/material.dart';

class ModernChargingProgress extends StatelessWidget {
  final double progress;
  final String remainingTime;

  const ModernChargingProgress({
    super.key,
    required this.progress,
    required this.remainingTime,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // แบ็คกราวด์วงกลม
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),

          // วงแหวนแสดงความคืบหน้า (แบบมีเอฟเฟกต์การชาร์จ)
          SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 10.0,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF4CD964),
              ), // สีเขียวแบบ iOS
              backgroundColor: Colors.white.withOpacity(0.1),
            ),
          ),

          // วงแหวนแสงด้านใน (เพิ่มความลึก)
          SizedBox(
            width: 180,
            height: 180,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 2.0,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white70),
              backgroundColor: Colors.transparent,
            ),
          ),

          // ข้อมูลกลางวงกลม
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // เปอร์เซ็นต์ (แบบมีเอฟเฟกต์)
              ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [Color(0xFF4CD964), Color(0xFF5AC8FA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Text(
                  '${(progress * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: Colors
                        .white, // ต้องตั้งค่าเป็น white เพื่อให้ ShaderMask ทำงาน
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // เวลาที่เหลือ
              Text(
                remainingTime,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          // เอฟเฟกต์จุดแสง (เพิ่มความทันสมัย)
          if (progress > 0)
            Positioned(
              top: 10 + (160 * (1 - progress)),
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CD964),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4CD964).withOpacity(0.8),
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
