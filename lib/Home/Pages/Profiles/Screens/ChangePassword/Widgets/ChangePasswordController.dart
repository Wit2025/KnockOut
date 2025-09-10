import 'package:flutter/material.dart';

class ChangePasswordController extends ChangeNotifier {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumbers = false;

  ChangePasswordController() {
    newPasswordController.addListener(_validateNewPassword);
  }

  void _validateNewPassword() {
    final text = newPasswordController.text;
    hasMinLength = text.length >= 6;
    hasUppercase = RegExp(r'[A-Z]').hasMatch(text);
    hasLowercase = RegExp(r'[a-z]').hasMatch(text);
    hasNumbers = RegExp(r'[0-9]').hasMatch(text);
    notifyListeners();
  }

  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'ກະລຸນາໃສ່ລະຫັດຜ່ານປະຈຸບັນ';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'ກະລຸນາໃສ່ລະຫັດຜ່ານໃໝ່';
    }
    if (value.length < 6) {
      return 'ລະຫັດຜ່ານຕ້ອງມີຢ່າງນ້ອຍ 6 ຕົວອັກສອນ';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'ລະຫັດຜ່ານຕ້ອງມີຕົວອັກສອນພິມໃຫຍ່';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'ລະຫັດຜ່ານຕ້ອງມີຕົວອັກສອນພິມນ້ອຍ';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'ລະຫັດຜ່ານຕ້ອງມີຕົວເລກ';
    }
    if (value == currentPasswordController.text) {
      return 'ລະຫັດຜ່ານໃໝ່ຕ້ອງຕ່າງຈາກລະຫັດຜ່ານເກົ່າ';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'ກະລຸນາຢືນຢັນລະຫັດຜ່ານໃໝ່';
    }
    if (value != newPasswordController.text) {
      return 'ລະຫັດຜ່ານຢືນຢັນບໍ່ຕົງກັນ';
    }
    return null;
  }

  bool validateForm() {
    return validateCurrentPassword(currentPasswordController.text) == null &&
        validateNewPassword(newPasswordController.text) == null &&
        validateConfirmPassword(confirmPasswordController.text) == null;
  }

  void toggleCurrentPasswordVisibility() {
    obscureCurrentPassword = !obscureCurrentPassword;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    obscureNewPassword = !obscureNewPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  void resetForm() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    hasMinLength = false;
    hasUppercase = false;
    hasLowercase = false;
    hasNumbers = false;
    notifyListeners();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
