import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';

class ServiceHeader extends StatelessWidget {
  const ServiceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            'ເລືອກບໍລິການ',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ເລືອກບໍລິການທີ່ຕ້ອງການໃຊ້',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
