import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const GradientAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 50, // สำหรับ Status Bar
        left: 16,
        right: 16,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.darkButton, AppColors.mainButton],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ชื่อเรื่อง (อยู่กลาง)
          Text(
            title,
            style: const TextStyle(
              color: AppColors.backgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          // ปุ่มกลับ (อยู่ซ้าย)
          if (showBackButton)
            Positioned(
              left: 0,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.backgroundColor,
                ),
                onPressed: onBackPressed ?? () => Navigator.pop(context),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
