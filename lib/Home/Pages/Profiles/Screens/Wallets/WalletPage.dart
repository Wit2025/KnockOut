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
            borderRadius: BorderRadius.circular(20),
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainButton,
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
                      labelStyle: const TextStyle(color: AppColors.mainButton),
                      prefixIcon: const Icon(
                        Icons.attach_money,
                        color: AppColors.mainButton,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.mainButton,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ກາລຸນາປ້ອງຈຳນວນເງິນ';
                      }

                      // แปลงจากรูปแบบแสดงผลกลับเป็นตัวเลขล้วน
                      String cleanText = value.replaceAll(',', '');

                      if (double.tryParse(cleanText) == null) {
                        return 'ກາລຸນາປ້ອນໂຕເລກເທົ່ານັ້ນ';
                      }

                      double amount = double.parse(cleanText);

                      if (amount <= 0) {
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
                            foregroundColor: AppColors.textColor,
                            side: const BorderSide(
                              color: AppColors.borderColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            _amountController.clear(); // ล้างค่าข้อมูล
                            Navigator.pop(context);
                          },
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
                              _topUpMoney(
                                _amountController.text,
                              ); // ส่งค่าเป็น String
                              _amountController.clear(); // ล้างค่าข้อมูล
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

  // ฟังก์ชันแสดง dialog ถอนเงิน
  void _showWithdrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
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
                    'ຖອນເງິນອອກຈາກບັນຊີ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainButton,
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
                      labelStyle: const TextStyle(color: AppColors.mainButton),
                      prefixIcon: const Icon(
                        Icons.attach_money,
                        color: AppColors.mainButton,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.mainButton,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ກາລຸນາປ້ອງຈຳນວນເງິນ';
                      }

                      // แปลงจากรูปแบบแสดงผลกลับเป็นตัวเลขล้วน
                      String cleanText = value.replaceAll(',', '');

                      if (double.tryParse(cleanText) == null) {
                        return 'ກາລຸນາປ້ອນໂຕເລກເທົ່ານັ້ນ';
                      }

                      double amount = double.parse(cleanText);

                      if (amount <= 0) {
                        return 'ຈຳນວນເງິນຕ້ອງໃຫຍ່ກວ່າ 0';
                      }

                      // สำหรับ validator ของถอนเงิน
                      if (amount > balance) {
                        return 'ຈຳນວນເງິນຖອນຫຼາຍກວ່າຍອດເງິນທີ່ເຫຼືອ';
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
                            foregroundColor: AppColors.textColor,
                            side: const BorderSide(
                              color: AppColors.borderColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            _amountController.clear(); // ล้างค่าข้อมูล
                            Navigator.pop(context);
                          },
                          child: const Text('ຍົກເລີກ'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: AppColors.backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _withdrawMoney(
                                _amountController.text,
                              ); // ส่งค่าเป็น String
                              _amountController.clear(); // ล้างค่าข้อมูล
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'ຖອນເງິນ',
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
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: AppColors.mainButton, width: 1.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: () {
        double current = 0;
        if (_amountController.text.isNotEmpty) {
          try {
            // แปลงจากรูปแบบแสดงผล (50,000.00) เป็นตัวเลขล้วน (50000)
            String cleanText = _amountController.text.replaceAll(',', '');
            current = double.parse(cleanText);
          } catch (_) {}
        }
        double newAmount = current + amount;

        // แสดงผลในรูปแบบมี comma แต่เก็บค่าเป็นตัวเลขล้วนใน controller
        _amountController.text = currencyFormat.format(newAmount);
      },
      child: Text(
        '+${currencyFormat.format(amount)}',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  // ฟังก์ชันเติมเงิน
  // ฟังก์ชันเติมเงิน
  void _topUpMoney(String formattedAmount) {
    // แปลงจากรูปแบบแสดงผลกลับเป็นตัวเลขล้วน
    String cleanText = formattedAmount.replaceAll(',', '');
    double amount = double.parse(cleanText);

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
        content: Text('ຕື່ມເງິນສຳເລັດ: ${currencyFormat.format(amount)} ກີບ'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  // ฟังก์ชันถอนเงิน
  void _withdrawMoney(String formattedAmount) {
    // แปลงจากรูปแบบแสดงผลกลับเป็นตัวเลขล้วน
    String cleanText = formattedAmount.replaceAll(',', '');
    double amount = double.parse(cleanText);

    setState(() {
      balance -= amount;
      transactions.insert(0, {
        'date':
            '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
        'description': 'ຖອນເງິນ',
        'amount': '-${currencyFormat.format(amount)} ກີບ',
        'type': 'debit',
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('ຖອນເງິນສຳເລັດ: ${currencyFormat.format(amount)} ກີບ'),
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
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.mainButton,
                    AppColors.darkButton,
                    AppColors.mainButton,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ຍອດເງິນທີ່ເຫຼືອ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${currencyFormat.format(balance)} ກີບ',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // ปุ่มเติมเงินและถอนเงิน
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _showTopUpDialog,
                            icon: const Icon(Icons.arrow_circle_down, size: 25),
                            label: const Text(
                              'ຕື່ມເງິນ',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.backgroundColor,
                              foregroundColor: AppColors.mainButton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _showWithdrawDialog,
                            icon: const Icon(Icons.arrow_circle_up, size: 25),
                            label: const Text(
                              'ຖອນເງິນ',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.textColor.withOpacity(
                                0.2,
                              ),
                              foregroundColor: AppColors.backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ส่วนประวัติการทำรายการ
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'ປະຫວັດການເຮັດທຸລະກຳ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  bool isCredit = transaction['type'] == 'credit';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textColor.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isCredit
                              ? AppColors.success.withOpacity(0.2)
                              : AppColors.error.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                          color: isCredit ? AppColors.success : AppColors.error,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        transaction['description'],
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        transaction['date'],
                        style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.6),
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            transaction['amount'],
                            style: TextStyle(
                              color: isCredit
                                  ? AppColors.success
                                  : AppColors.error,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
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
