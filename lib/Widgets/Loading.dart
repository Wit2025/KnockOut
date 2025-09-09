import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';

class LoadingDialog extends StatelessWidget {
  final String message;
  const LoadingDialog({Key? key, this.message = "ກຳລັງດຳເນີນການ..."})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.mainButton),
              strokeWidth: 3,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
