// หน้า Wallet
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knockout/Widgets/AppBar.dart';
import 'package:knockout/Widgets/AppColors.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  // ข้อมูลจำลองสำหรับหน้า Wallet
  double balance = 270000.00;
  final List<Map<String, dynamic>> transactions = [
    {
      'date': '2024-05-01',
      'description': 'ຕື່ມເງິນ',
      'amount': '+100,000.00 ກີບ',
      'type': 'credit',
    },
    {
      'date': '2024-05-02',
      'description': 'ລ້າງທຳມະດາ',
      'amount': '-10,000.00 ກີບ',
      'type': 'debit',
    },
    {
      'date': '2024-05-03',
      'description': 'ຕື່ມເງິນ',
      'amount': '+200,000.00 ກີບ',
      'type': 'credit',
    },
    {
      'date': '2024-05-04',
      'description': 'ລ້າງ + ປັ້ນແຫ້ງ',
      'amount': '-30,000.00 ກີບ',
      'type': 'debit',
    },
  ];

  // ตัวแปรสำหรับฟอร์มเติมเงิน
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");

  // ฟังก์ชันแสดง dialog เติมเงิน
  void _showTopUpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // มุมโค้ง
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // หัวข้อ
                  const Text(
                    'ຕື່ມເງິນເຂົ້າບັນຊີ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // ช่องกรอกจำนวนเงิน
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'ຈຳນວນເງິນ',
                      prefixIcon: const Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ກາລຸນາປ້ອງຈຳນວນເງິນ';
                      }
                      if (double.tryParse(value) == null) {
                        return 'ກາລຸນາປ້ອນໂຕເລກເທົ່ານັ້ນ';
                      }
                      if (double.parse(value) <= 0) {
                        return 'ຈຳນວນເງິນຕ້ອງໃຫຍ່ກວ່າ 0';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // ปุ่มเลือกจำนวนเงินด่วน
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildQuickAmountButton(50000),
                          _buildQuickAmountButton(100000),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ปุ่ม action
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('ຍົກເລີກ'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainButton,
                            foregroundColor: AppColors.backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _topUpMoney(double.parse(_amountController.text));
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'ຕື່ມເງິນ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// ปุ่ม quick amount แบบทันสมัย
  Widget _buildQuickAmountButton(double amount) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // ปุ่มกลมๆ
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: () {
        double current = 0;
        if (_amountController.text.isNotEmpty) {
          try {
            current = currencyFormat.parse(_amountController.text).toDouble();
          } catch (_) {}
        }
        double newAmount = current + amount;
        _amountController.text = currencyFormat.format(newAmount);
      },
      child: Text(
        '+${currencyFormat.format(amount)}', // แสดงแบบฟอร์แมต
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  // ฟังก์ชันเติมเงิน
  void _topUpMoney(double amount) {
    setState(() {
      balance += amount;
      transactions.insert(0, {
        'date':
            '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
        'description': 'ຕື່ມເງິນ',
        'amount': '+${currencyFormat.format(amount)} ກີບ',
        'type': 'credit',
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('ຕື່ມເງິນສຳເລັດ: ${amount.toStringAsFixed(2)} ກີບ'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: GradientAppBar(title: 'ກະເປົາເງິນ', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // บัตรแสดงยอดเงิน
            Card(
              color: AppColors.backgroundColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ຍອດເງິນທີ່ເຫຼືອ',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.borderColor,
                          ),
                        ),
                        Text(
                          '${currencyFormat.format(balance)} ກີບ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: _showTopUpDialog, // เปลี่ยนเป็นเรียก dialog
                      icon: const Icon(Icons.add_circle_outline),
                      label: const Text('ຕື່ມເງິນ'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainButton,
                        foregroundColor: AppColors.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ส่วนประวัติการทำรายการ
            const Text(
              'ປະຫວັດການເຮັດທຸລະກຳ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  bool isCredit = transaction['type'] == 'credit';
                  return Card(
                    color: AppColors.backgroundColor,
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(
                        isCredit ? Icons.add_circle : Icons.remove_circle,
                        color: isCredit ? AppColors.success : AppColors.error,
                      ),
                      title: Text(transaction['description']),
                      subtitle: Text(transaction['date']),
                      trailing: Text(
                        transaction['amount'],
                        style: TextStyle(
                          color: isCredit ? AppColors.success : AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
