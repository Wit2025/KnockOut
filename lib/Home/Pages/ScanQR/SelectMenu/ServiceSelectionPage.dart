import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/ScanQR/SelectMenu/ConfirmOrder/ConfirmOrderPage.dart';
import 'package:knockout/Widgets/AppBar.dart';
import 'package:knockout/Widgets/AppColors.dart';
import 'package:knockout/Home/Pages/ScanQR/SelectMenu/Widgets/SelectServiceCard.dart';
import 'package:knockout/Home/Pages/ScanQR/SelectMenu/Widgets/ServiceHeader.dart';
import 'package:knockout/Home/Pages/ScanQR/SelectMenu/Widgets/PriceSummaryCard.dart';
import 'package:knockout/Home/Pages/ScanQR/SelectMenu/Widgets/ContinueButton.dart';

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
                    const ServiceHeader(),

                    // Service Selection Cards
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                      children: servicePrices.entries.map((entry) {
                        return SelectServiceCard(
                          serviceName: entry.key,
                          price: entry.value,
                          isSelected: selectedService == entry.key,
                          onTap: () {
                            setState(() {
                              selectedService = entry.key;
                              calculatePrice();
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Price Display Card
                    PriceSummaryCard(
                      selectedService: selectedService,
                      price: price,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Continue Button
            ContinueButton(
              isEnabled: selectedService != null,
              onPressed: () {
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
            ),
          ],
        ),
      ),
    );
  }
}
