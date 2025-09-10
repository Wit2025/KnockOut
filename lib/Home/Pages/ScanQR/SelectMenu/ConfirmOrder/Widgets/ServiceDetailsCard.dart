import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knockout/Home/Pages/ScanQR/SelectMenu/ConfirmOrder/Widgets/ServiceDetailRow.dart';
import 'package:knockout/Widgets/AppColors.dart';

class ServiceDetailsCard extends StatelessWidget {
  final String service;
  final int time;
  final double price;

  const ServiceDetailsCard({
    super.key,
    required this.service,
    required this.time,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Title
          Text(
            'ລາຍລະອຽດບໍລິການ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 20),

          // Service Info
          ServiceDetailRow(
            icon: Icons.local_car_wash,
            title: 'ປະເພດບໍລິການ',
            value: service,
          ),
          const SizedBox(height: 16),
          ServiceDetailRow(
            icon: Icons.access_time,
            title: 'ໃຊ້ເວລາໃນການລ້າງ',
            value: '$time ນາທີ',
          ),
          const SizedBox(height: 20),

          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.mainButton.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Price Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ລາຄາລວມ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              Text(
                '${NumberFormat("#,##0.00", "en_US").format(price)} ກີບ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainButton,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: AppColors.mainButton.withOpacity(0.3),
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
