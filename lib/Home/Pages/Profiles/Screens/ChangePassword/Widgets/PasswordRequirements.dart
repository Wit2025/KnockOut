import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/ChangePassword/Widgets/ChangePasswordController.dart';
import 'package:knockout/Widgets/AppColors.dart';

class PasswordRequirements extends StatelessWidget {
  final ChangePasswordController controller;

  const PasswordRequirements({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.mainButton.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mainButton.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ລະຫັດຜ່ານຕ້ອງ:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 12),
          _buildPasswordRequirement('ຕ້ອງມີຢ່າງນ້ອຍ 6 ຕົວອັກສອນ', controller.hasMinLength),
          const SizedBox(height: 8),
          _buildPasswordRequirement('ຕ້ອງມີຕົວອັກສອນພິມໃຫຍ່ (A-Z)', controller.hasUppercase),
          const SizedBox(height: 8),
          _buildPasswordRequirement('ຕ້ອງມີຕົວອັກສອນພິມນ້ອຍ (a-z)', controller.hasLowercase),
          const SizedBox(height: 8),
          _buildPasswordRequirement('ຕ້ອງມີຕົວເລກ (0-9)', controller.hasNumbers),
        ],
      ),
    );
  }

  Widget _buildPasswordRequirement(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle,
          size: 16,
          color: isMet ? AppColors.success : AppColors.iconUnselect,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isMet ? AppColors.success : AppColors.iconUnselect,
          ),
        ),
      ],
    );
  }
}