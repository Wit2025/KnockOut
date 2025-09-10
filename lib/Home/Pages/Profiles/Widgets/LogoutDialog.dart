import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:knockout/Widgets/AppColors.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'ອອກຈາກລະບົບ',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.mainButton,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        'ທ່ານແນ່ໃຈວ່າຈະອອກຈາກລະບົບບໍ່?',
        style: TextStyle(fontSize: 16, color: AppColors.mainButton),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('ຍົກເລິກ', style: TextStyle(color: AppColors.textColor)),
        ),
        ElevatedButton(
          onPressed: () async {
            // ลบค่า login
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('isLoggedIn');

            // ปิด dialog
            Navigator.pop(context);

            // กลับไปหน้า Login
            Navigator.pushReplacementNamed(context, '/login');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'ອອກຈາກລະບົບ',
            style: TextStyle(color: AppColors.backgroundColor),
          ),
        ),
      ],
    );
  }
}
