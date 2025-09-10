import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knockout/Widgets/AppColors.dart';

class SelectServiceCard extends StatelessWidget {
  final String serviceName;
  final double price;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectServiceCard({
    super.key,
    required this.serviceName,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  // Helper function to get icon for each service
  IconData _getServiceIcon(String serviceName) {
    switch (serviceName) {
      case 'ລ້າງທຳມະດາ':
        return Icons.local_car_wash;
      case 'ລ້າງ Premium':
        return Icons.directions_car;
      case 'ຂ້າເຊື້ອ':
        return Icons.clean_hands;
      case 'ລ້າງ + ອົບແຫ້ງ':
        return Icons.local_laundry_service;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.mainButton.withOpacity(0.15)
              : AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.mainButton
                : AppColors.borderColor.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.textColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Service Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.mainButton
                      : AppColors.mainButton.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getServiceIcon(serviceName),
                  color: isSelected
                      ? AppColors.backgroundColor
                      : AppColors.mainButton,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              // Service Name
              Text(
                serviceName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 8),
              // Service Price
              Text(
                '${NumberFormat("#,##0.00", "en_US").format(price)} ກີບ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
