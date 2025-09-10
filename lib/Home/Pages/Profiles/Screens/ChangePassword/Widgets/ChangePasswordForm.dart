import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/ChangePassword/Widgets/ChangePasswordController.dart';
import 'package:knockout/Widgets/AppColors.dart';

class ChangePasswordForm extends StatelessWidget {
  final ChangePasswordController controller;

  const ChangePasswordForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCurrentPasswordField(),
        const SizedBox(height: 20),
        _buildNewPasswordField(),
        const SizedBox(height: 20),
        _buildConfirmPasswordField(),
      ],
    );
  }

  Widget _buildCurrentPasswordField() {
    return TextFormField(
      controller: controller.currentPasswordController,
      obscureText: controller.obscureCurrentPassword,
      decoration: InputDecoration(
        labelText: 'ລະຫັດຜ່ານປະຈຸບັນ',
        labelStyle: const TextStyle(color: AppColors.mainButton),
        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.mainButton),
        suffixIcon: IconButton(
          icon: Icon(
            controller.obscureCurrentPassword
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.mainButton.withOpacity(0.6),
          ),
          onPressed: controller.toggleCurrentPasswordVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.mainButton),
        ),
      ),
      validator: controller.validateCurrentPassword,
    );
  }

  Widget _buildNewPasswordField() {
    return TextFormField(
      controller: controller.newPasswordController,
      obscureText: controller.obscureNewPassword,
      decoration: InputDecoration(
        labelText: 'ລະຫັດຜ່ານໃໝ່',
        labelStyle: const TextStyle(color: AppColors.mainButton),
        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.mainButton),
        suffixIcon: IconButton(
          icon: Icon(
            controller.obscureNewPassword
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.mainButton.withOpacity(0.6),
          ),
          onPressed: controller.toggleNewPasswordVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.mainButton),
        ),
      ),
      validator: controller.validateNewPassword,
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: controller.confirmPasswordController,
      obscureText: controller.obscureConfirmPassword,
      decoration: InputDecoration(
        labelText: 'ຢືນຢັນລະຫັດຜ່ານໃໝ່',
        labelStyle: const TextStyle(color: AppColors.mainButton),
        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.mainButton),
        suffixIcon: IconButton(
          icon: Icon(
            controller.obscureConfirmPassword
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.mainButton.withOpacity(0.6),
          ),
          onPressed: controller.toggleConfirmPasswordVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.mainButton),
        ),
      ),
      validator: controller.validateConfirmPassword,
    );
  }
}
