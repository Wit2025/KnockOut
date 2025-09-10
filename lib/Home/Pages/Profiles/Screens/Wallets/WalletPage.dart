import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Wallets/Widgets/TopUpDialog.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Wallets/Widgets/Transaction.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Wallets/Widgets/TransactionList.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Wallets/Widgets/WalletCard.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Wallets/Widgets/WithdrawDialog.dart';
import 'package:knockout/Widgets/AppBar.dart';
import 'package:knockout/Widgets/AppColors.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double balance = 270000.00;
  final List<Transaction> transactions = [
    Transaction(
      date: '2024-05-01',
      description: 'ຕື່ມເງິນ',
      amount: '+100,000.00 ກີບ',
      type: 'credit',
    ),
    Transaction(
      date: '2024-05-02',
      description: 'ຖອນເງິນ',
      amount: '-10,000.00 ກີບ',
      type: 'debit',
    ),

    Transaction(
      date: '2024-05-04',
      description: 'ຖອນເງິນ',
      amount: '-30,000.00 ກີບ',
      type: 'debit',
    ),
    Transaction(
      date: '2024-05-03',
      description: 'ຕື່ມເງິນ',
      amount: '+200,000.00 ກີບ',
      type: 'credit',
    ),
  ];

  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");

  void _showTopUpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TopUpDialog(
          amountController: _amountController,
          formKey: _formKey,
          currencyFormat: currencyFormat,
          onCancel: () {
            _amountController.clear();
            Navigator.pop(context);
          },
          onConfirm: () {
            if (_formKey.currentState!.validate()) {
              _topUpMoney(_amountController.text);
              _amountController.clear();
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  void _showWithdrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WithdrawDialog(
          amountController: _amountController,
          formKey: _formKey,
          currencyFormat: currencyFormat,
          balance: balance,
          onCancel: () {
            _amountController.clear();
            Navigator.pop(context);
          },
          onConfirm: () {
            if (_formKey.currentState!.validate()) {
              _withdrawMoney(_amountController.text);
              _amountController.clear();
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  void _topUpMoney(String formattedAmount) {
    String cleanText = formattedAmount.replaceAll(',', '');
    double amount = double.parse(cleanText);

    setState(() {
      balance += amount;
      transactions.insert(
        0,
        Transaction(
          date:
              '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
          description: 'ຕື່ມເງິນ',
          amount: '+${currencyFormat.format(amount)} ກີບ',
          type: 'credit',
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('ຕື່ມເງິນສຳເລັດ: ${currencyFormat.format(amount)} ກີບ'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _withdrawMoney(String formattedAmount) {
    String cleanText = formattedAmount.replaceAll(',', '');
    double amount = double.parse(cleanText);

    setState(() {
      balance -= amount;
      transactions.insert(
        0,
        Transaction(
          date:
              '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
          description: 'ຖອນເງິນ',
          amount: '-${currencyFormat.format(amount)} ກີບ',
          type: 'debit',
        ),
      );
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
            WalletCard(
              balance: balance,
              currencyFormat: currencyFormat,
              onTopUp: _showTopUpDialog,
              onWithdraw: _showWithdrawDialog,
            ),
            const SizedBox(height: 24),
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
            TransactionList(transactions: transactions),
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
