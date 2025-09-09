import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.darkButton,
              AppColors.mainButton,
              AppColors.third,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.security,
                    size: 50,
                    color: AppColors.backgroundColor,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Knock Out',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'ບໍລິການລ້າງໝວກກັນນ໋ອກ',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.backgroundColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 64),

                // Login Button
                Container(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login'); // ใช้ named route
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.backgroundColor,
                      foregroundColor: AppColors.mainButton,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      'ເຂົ້າສູ່ລະບົບ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Register Button
                Container(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/register',
                      ); // ใช้ named route
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.backgroundColor,
                      side: BorderSide(
                        color: AppColors.backgroundColor,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'ສ້າງບັນຊີ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),

                // Social Login
                Text(
                  'ຫຼື ເຂົ້າສູ່ລະບົບດ້ວຍ',
                  style: TextStyle(color: AppColors.textColor),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildSocialButton(
                        'assets/images/g.png',
                        'Google',
                        AppColors.backgroundColor,
                        AppColors.textColor,
                        () {},
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _buildSocialButton(
                        'assets/images/f.png',
                        'Facebook',
                        AppColors.mainButton,
                        AppColors.backgroundColor,
                        () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    String imagePath,
    String title,
    Color backgroundColor,
    Color textColor, // เพิ่มพารามิเตอร์สำหรับสีข้อความ
    VoidCallback onPressed,
  ) {
    return Container(
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor, // ใช้ textColor ที่ส่งมา
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 20, height: 20, fit: BoxFit.contain),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 20, // ลดขนาดฟอนต์จาก 20 เป็น 14
                fontWeight: FontWeight.w600,
                color: textColor, // ใช้ textColor ที่ส่งมา
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
