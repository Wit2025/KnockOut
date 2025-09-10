import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';

class ContinueButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const ContinueButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? AppColors.mainButton
              : AppColors.borderColor.withOpacity(0.5),
          foregroundColor: AppColors.backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: AppColors.mainButton.withOpacity(0.5),
        ),
        child: Text(
          'ດຳເນີນການຕໍ່',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isEnabled
                ? AppColors.backgroundColor
                : AppColors.iconUnselect,
          ),
        ),
      ),
    );
  }
}
