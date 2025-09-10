import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';
import 'ProcessStepIndicator.dart';

class ProcessStepsContainer extends StatelessWidget {
  final double progress;

  const ProcessStepsContainer({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainButton.withOpacity(0.7),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.backgroundColor, AppColors.backgroundColor],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              const Text(
                'ຂັ້ນຕອນການເຮັດວຽກ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ProcessStepIndicator(
            step: 'ຕື່ມນ້ຳ',
            isCompleted: progress > 0.1,
            isActive: progress > 0 && progress <= 0.1,
            index: 0,
          ),
          ProcessStepIndicator(
            step: 'ລ້າງໝວກ',
            isCompleted: progress > 0.3,
            isActive: progress > 0.1 && progress <= 0.3,
            index: 1,
          ),
          ProcessStepIndicator(
            step: 'ໄຫຼນ້ຳ',
            isCompleted: progress > 0.7,
            isActive: progress > 0.3 && progress <= 0.7,
            index: 2,
          ),
          ProcessStepIndicator(
            step: 'ປັ້ນແຫ້ງ',
            isCompleted: progress > 0.99,
            isActive: progress > 0.7 && progress <= 0.99,
            index: 3,
          ),
        ],
      ),
    );
  }
}
