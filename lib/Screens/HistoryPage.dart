// หน้าประวัติการใช้งาน
import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final currencyFormatter = NumberFormat("#,##0.00", "en_US");

  final List<Map<String, dynamic>> history = const [
    {
      'date': '2024-05-04',
      'service': 'ລ້າງ + ອົບແຫ້ງ',
      'price': 30000.00,
      'status': 'ສຳເລັດ',
    },
    {
      'date': '2024-05-03',
      'service': 'ຊ້າເຊື້ອ',
      'price': 25000.00,
      'status': 'ສຳເລັດ',
    },
    {
      'date': '2024-05-02',
      'service': 'ລ້າງທຳມະດາ',
      'price': 10000.00,
      'status': 'ສຳເລັດ',
    },
    {
      'date': '2024-05-01',
      'service': 'ລ້າງທຳມະດາ',
      'price': 10000.00,
      'status': 'ບໍ່ສຳເລັດ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          Color statusColor = item['status'] == 'ສຳເລັດ'
              ? AppColors.success
              : AppColors.error;
          return Card(
            color: AppColors.backgroundColor,
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(
                item['status'] == 'ສຳເລັດ' ? Icons.check_circle : Icons.cancel,
                color: statusColor,
              ),
              title: Text(item['service']),
              subtitle: Text(item['date']),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' ${currencyFormatter.format(item['price'])} ກີບ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(item['status'], style: TextStyle(color: statusColor)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
