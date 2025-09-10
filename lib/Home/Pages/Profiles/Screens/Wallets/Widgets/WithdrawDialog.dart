import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knockout/Widgets/AppColors.dart';

class WithdrawDialog extends StatelessWidget {
  final TextEditingController amountController;
  final GlobalKey<FormState> formKey;
  final NumberFormat currencyFormat;
  final double balance;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const WithdrawDialog({
    super.key,
    required this.amountController,
    required this.formKey,
    required this.currencyFormat,
    required this.balance,
    required this.onCancel,
    required this.onConfirm,
  });

  Widget _buildQuickAmountButton(double amount, VoidCallback onPressed) {
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
      onPressed: onPressed,
      child: Text(
        '+${currencyFormat.format(amount)}',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              TextFormField(
                controller: amountController,
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
                    borderSide: const BorderSide(color: AppColors.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.mainButton),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ກາລຸນາປ້ອງຈຳນວນເງິນ';
                  }
                  String cleanText = value.replaceAll(',', '');
                  if (double.tryParse(cleanText) == null) {
                    return 'ກາລຸນາປ້ອນໂຕເລກເທົ່ານັ້ນ';
                  }
                  double amount = double.parse(cleanText);
                  if (amount <= 0) {
                    return 'ຈຳນວນເງິນຕ້ອງໃຫຍ່ກວ່າ 0';
                  }
                  if (amount > balance) {
                    return 'ຈຳນວນເງິນຖອນຫຼາຍກວ່າຍອດເງິນທີ່ເຫຼືອ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildQuickAmountButton(50000, () {
                        double current = 0;
                        if (amountController.text.isNotEmpty) {
                          try {
                            String cleanText = amountController.text.replaceAll(
                              ',',
                              '',
                            );
                            current = double.parse(cleanText);
                          } catch (_) {}
                        }
                        double newAmount = current + 50000;
                        amountController.text = currencyFormat.format(
                          newAmount,
                        );
                      }),
                      _buildQuickAmountButton(100000, () {
                        double current = 0;
                        if (amountController.text.isNotEmpty) {
                          try {
                            String cleanText = amountController.text.replaceAll(
                              ',',
                              '',
                            );
                            current = double.parse(cleanText);
                          } catch (_) {}
                        }
                        double newAmount = current + 100000;
                        amountController.text = currencyFormat.format(
                          newAmount,
                        );
                      }),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textColor,
                        side: const BorderSide(color: AppColors.borderColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: onCancel,
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
                      onPressed: onConfirm,
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
  }
}
