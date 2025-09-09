import 'package:flutter/material.dart';
import 'package:knockout/Screens/ConfirmOrderPage.dart';
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
                    const Text(
                      'ເລືອກບໍລິການທີ່ຕ້ອງການໃຊ້',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...servicePrices.keys.map((service) {
                      return RadioListTile<String>(
                        title: Text(service),
                        value: service,
                        groupValue: selectedService,
                        activeColor: AppColors.mainButton,
                        onChanged: (String? value) {
                          setState(() {
                            selectedService = value;
                            calculatePrice();
                          });
                        },
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'ລາຄາ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.iconSelect,
                              ),
                            ),
                            Text(
                              '${price.toStringAsFixed(2)} ກີບ',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.iconSelect,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
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
                  backgroundColor: AppColors.mainButton,
                  foregroundColor: AppColors.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'ດຳເນີນການຕໍ່',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
