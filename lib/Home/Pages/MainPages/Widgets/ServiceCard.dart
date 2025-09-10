import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/ScanQR/ScanQRCodePage.dart';
import 'package:knockout/Widgets/AppColors.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String price;
  final IconData icon;
  final Color color;
  final String serviceType;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.price,
    required this.icon,
    required this.color,
    required this.serviceType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double numericPrice = double.parse(
      price.replaceAll(',', '').replaceAll('ກີບ', '').trim(),
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRScannerScreen(
              selectedService: serviceType,
              selectedPrice: numericPrice,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.textColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
