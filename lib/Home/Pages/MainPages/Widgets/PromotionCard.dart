import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';

class PromotionCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;

  const PromotionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.local_offer, color: AppColors.backgroundColor, size: 28),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: AppColors.backgroundColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(color: AppColors.backgroundColor, fontSize: 14),
          ),
        ],
      ),
    );
  }
}