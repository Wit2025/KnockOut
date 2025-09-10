import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knockout/Widgets/AppColors.dart';

class PriceSummaryCard extends StatelessWidget {
  final String? selectedService;
  final double price;

  const PriceSummaryCard({
    super.key,
    required this.selectedService,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.mainButton.withOpacity(0.8), AppColors.darkButton],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainButton.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ລາຄາລວມ',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.backgroundColor.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedService ?? 'ເລືອກບໍລິການ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.backgroundColor,
                ),
              ),
              Text(
                '${NumberFormat("#,##0.00", "en_US").format(price)} ກີບ',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.backgroundColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
