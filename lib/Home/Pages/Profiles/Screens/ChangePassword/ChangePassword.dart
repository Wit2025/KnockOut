import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/ChangePassword/Widgets/ChangePasswordController.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/ChangePassword/Widgets/ChangePasswordForm.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/ChangePassword/Widgets/PasswordRequirements.dart';
import 'package:knockout/Widgets/AppBar.dart';
import 'package:knockout/Widgets/AppColors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final ChangePasswordController _controller = ChangePasswordController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {});
  }

  void _changePassword() {
    if (_controller.validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('ປ່ຽນລະຫັດຜ່ານສຳເລັດ'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );

      _controller.resetForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: GradientAppBar(title: 'ປ່ຽນລະຫັດຜ່ານ', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'ປ່ຽນລະຫັດຜ່ານຂອງທ່ານ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 32),

            ChangePasswordForm(controller: _controller),
            const SizedBox(height: 16),
            PasswordRequirements(controller: _controller),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainButton,
                  foregroundColor: AppColors.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'ປ່ຽນລະຫັດຜ່ານ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
