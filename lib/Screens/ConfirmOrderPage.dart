import 'package:flutter/material.dart';
import 'package:knockout/Screens/TrackingPage.dart';
import 'package:knockout/Widgets/AppColors.dart';
import 'package:knockout/Widgets/Loading.dart';

class OrderSummaryPage extends StatefulWidget {
  final Map<String, dynamic> serviceData;

  const OrderSummaryPage({super.key, required this.serviceData});

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final String service = widget.serviceData['service'];
    final int time = widget.serviceData['time'];
    final double price = widget.serviceData['price'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຢືນຢັນ',
          style: TextStyle(
            color: AppColors.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.backgroundColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.iconSelect, AppColors.mainButton],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: AppColors.mainButton.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ບໍລິການທີ່ເລືອກ: $service',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'ເວລາທີ່ໃຊ້: $time ນາທີ',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        const Divider(thickness: 1),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'ລາຄາ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${price.toStringAsFixed(2)} ກີບ',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.iconSelect,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const LoadingDialog(),
                  );

                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pop(context); // ปิด dialog

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RealtimeTrackingPage(processTime: time),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainButton,
                  foregroundColor: AppColors.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'ຢືນຢັນ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
