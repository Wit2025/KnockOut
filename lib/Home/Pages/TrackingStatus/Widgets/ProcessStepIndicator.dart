import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';
import 'package:knockout/Home/Pages/TrackingStatus/Widgets/SpinningCircleWidget.dart';

class ProcessStepIndicator extends StatelessWidget {
  final String step;
  final bool isCompleted;
  final bool isActive;
  final int index;

  const ProcessStepIndicator({
    super.key,
    required this.step,
    required this.isCompleted,
    required this.isActive,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500 + (index * 200)),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppColors.mainButton.withOpacity(0.1)
            : AppColors.borderColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted
              ? AppColors.mainButton.withOpacity(0.3)
              : AppColors.borderColor.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: isCompleted
            ? [
                BoxShadow(
                  color: AppColors.mainButton.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // แสดงการหมุนเฉพาะเมื่อกำลังทำงาน (isActive) และยังไม่เสร็จ
          isCompleted
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutBack,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.mainButton,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.backgroundColor,
                    size: 16,
                  ),
                )
              : isActive
                  ? SpinningCircleWidget(
                      mainColor: AppColors.mainButton,
                      backgroundColor: AppColors.backgroundColor,
                    )
                  : Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.borderColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.circle,
                        color: AppColors.backgroundColor,
                        size: 16,
                      ),
                    ),
          const SizedBox(width: 16),
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 16,
                fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
                color: isCompleted ? AppColors.mainButton : AppColors.textColor,
                decoration: isCompleted
                    ? TextDecoration.none
                    : TextDecoration.none,
              ),
              child: Text(step),
            ),
          ),
          if (isCompleted)
            Icon(Icons.verified_rounded, color: AppColors.mainButton, size: 20),
        ],
      ),
    );
  }
}