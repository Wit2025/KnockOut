import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Wallets/Widgets/Transaction.dart';
import 'package:knockout/Widgets/AppColors.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
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
                  color: transaction.isCredit
                      ? AppColors.success.withOpacity(0.2)
                      : AppColors.error.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  transaction.isCredit
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: transaction.isCredit
                      ? AppColors.success
                      : AppColors.error,
                  size: 20,
                ),
              ),
              title: Text(
                transaction.description,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                transaction.date,
                style: TextStyle(color: AppColors.textColor.withOpacity(0.6)),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    transaction.amount,
                    style: TextStyle(
                      color: transaction.isCredit
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
    );
  }
}
