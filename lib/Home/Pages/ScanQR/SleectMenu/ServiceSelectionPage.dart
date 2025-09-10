import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knockout/Home/Pages/ScanQR/SleectMenu/ConfirmOrder/ConfirmOrderPage.dart';
import 'package:knockout/Widgets/AppBar.dart';
import 'package:knockout/Widgets/AppColors.dart';

class ServiceSelectionPage extends StatefulWidget {
  final String? selectedService;

  const ServiceSelectionPage({super.key, this.selectedService});

  @override
  _ServiceSelectionPageState createState() => _ServiceSelectionPageState();
}

class _ServiceSelectionPageState extends State<ServiceSelectionPage> {
  String? selectedService;
  int selectedTime = 8;
  double price = 0.0;
  final TextEditingController _timeController = TextEditingController();

  final Map<String, double> servicePrices = {
    'ລ້າງທຳມະດາ': 10000.00,
    'ລ້າງ Premium': 20000.00,
    'ຂ້າເຊື້ອ': 25000.00,
    'ລ້າງ + ອົບແຫ້ງ': 30000.00,
  };

  @override
  void initState() {
    super.initState();
    if (widget.selectedService != null) {
      selectedService = widget.selectedService;
    }
    _timeController.text = selectedTime.toString();
    calculatePrice();
  }

  void calculatePrice() {
    setState(() {
      price = selectedService != null ? servicePrices[selectedService]! : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: GradientAppBar(title: 'ເລືອກບໍລິການ', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header Section
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Text(
                            'ເລືອກບໍລິການ',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'ເລືອກບໍລິການທີ່ຕ້ອງການໃຊ້',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Service Selection Cards
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                      children: servicePrices.entries.map((entry) {
                        final isSelected = selectedService == entry.key;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedService = entry.key;
                              calculatePrice();
                            });
                          },
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
                                          : AppColors.mainButton.withOpacity(
                                              0.1,
                                            ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _getServiceIcon(entry.key),
                                      color: isSelected
                                          ? AppColors.backgroundColor
                                          : AppColors.mainButton,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  // Service Name
                                  Text(
                                    entry.key,
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
                                    '${NumberFormat("#,##0.00", "en_US").format(entry.value)} ກີບ',
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
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Price Display Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.mainButton.withOpacity(0.8),
                            AppColors.darkButton,
                          ],
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
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedService == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderSummaryPage(
                              serviceData: {
                                'service': selectedService,
                                'time': selectedTime,
                                'price': price,
                              },
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedService == null
                      ? AppColors.borderColor.withOpacity(0.5)
                      : AppColors.mainButton,
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
                    color: selectedService == null
                        ? AppColors.iconUnselect
                        : AppColors.backgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
