import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';

class CameraErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onBackPressed;

  const CameraErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ເກີດຂໍ້ຜິດພາດ'),
        backgroundColor: AppColors.error,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 20),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: onBackPressed,
                child: const Text('ຍ້ອນກັບ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
